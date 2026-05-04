#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="check"

log() {
  echo "[${SCRIPT_NAME}] $*"
}

error() {
  echo "[${SCRIPT_NAME}] ERRO: $*" >&2
}

if ! command -v kubectl >/dev/null 2>&1; then
  error "kubectl não encontrado no PATH."
  exit 1
fi

if ! kubectl cluster-info >/dev/null 2>&1; then
  error "não foi possível acessar o cluster Kubernetes no contexto atual."
  exit 1
fi

log "Coletando status do cluster..."

log "kubectl get namespaces"
kubectl get namespaces
echo

log "kubectl get pods -A"
kubectl get pods -A
echo

log "kubectl get svc -A"
kubectl get svc -A
echo

log "kubectl get resourcequota -A"
kubectl get resourcequota -A
echo

log "kubectl get limitrange -A"
kubectl get limitrange -A
echo

CURRENT_CONTEXT="$(kubectl config current-context)"

TOTAL_NAMESPACES="$(kubectl get namespaces --no-headers 2>/dev/null | wc -l | awk '{print $1}')"
TOTAL_SERVICES="$(kubectl get svc -A --no-headers 2>/dev/null | wc -l | awk '{print $1}')"
TOTAL_QUOTAS="$(kubectl get resourcequota -A --no-headers 2>/dev/null | wc -l | awk '{print $1}')"
TOTAL_LIMITRANGES="$(kubectl get limitrange -A --no-headers 2>/dev/null | wc -l | awk '{print $1}')"

PODS_BY_NAMESPACE="$(kubectl get pods -A --no-headers 2>/dev/null | awk '{count[$1]++} END {for (ns in count) printf "%s: %d\n", ns, count[ns]}' | sort)"

log "Resumo final"
echo "- Contexto atual: ${CURRENT_CONTEXT}"
echo "- Total de namespaces: ${TOTAL_NAMESPACES}"
echo "- Total de services: ${TOTAL_SERVICES}"
echo "- Total de resourcequotas: ${TOTAL_QUOTAS}"
echo "- Total de limitranges: ${TOTAL_LIMITRANGES}"
echo "- Pods por namespace:"
if [[ -n "${PODS_BY_NAMESPACE}" ]]; then
  while IFS= read -r line; do
    echo "  - ${line}"
  done <<< "${PODS_BY_NAMESPACE}"
else
  echo "  - Nenhum pod encontrado."
fi

log "Sucesso: checagem concluída."
