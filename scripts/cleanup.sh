#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="cleanup"

log() {
  echo "[${SCRIPT_NAME}] $*"
}

error() {
  echo "[${SCRIPT_NAME}] ERRO: $*" >&2
}

warn() {
  echo "[${SCRIPT_NAME}] ALERTA: $*"
}

if ! command -v kubectl >/dev/null 2>&1; then
  error "kubectl não encontrado no PATH."
  exit 1
fi

if ! kubectl cluster-info >/dev/null 2>&1; then
  error "não foi possível acessar o cluster no contexto atual."
  exit 1
fi

LAB_NAMESPACES=(
  "dev"
  "staging"
  "prod"
  "qa"
  "shared"
  "backend"
  "frontend"
  "resources-lab"
  "qos-lab"
  "limitrange-lab"
  "quota-lab"
)

PROTECTED_NAMESPACES=(
  "default"
  "kube-system"
  "kube-public"
  "kube-node-lease"
)

is_protected_namespace() {
  local ns="$1"
  for protected in "${PROTECTED_NAMESPACES[@]}"; do
    if [[ "${ns}" == "${protected}" ]]; then
      return 0
    fi
  done
  return 1
}

namespace_exists() {
  local ns="$1"
  kubectl get namespace "${ns}" >/dev/null 2>&1
}

log "Iniciando limpeza dos namespaces do laboratório."
log "Somente os namespaces abaixo serão removidos (se existirem):"
for ns in "${LAB_NAMESPACES[@]}"; do
  echo "  - ${ns}"
done

log "Namespaces protegidos (nunca removidos por este script):"
for ns in "${PROTECTED_NAMESPACES[@]}"; do
  echo "  - ${ns}"
done

log "Este script não remove cluster, não altera kubeconfig e não toca em namespaces de sistema."

for ns in "${LAB_NAMESPACES[@]}"; do
  if is_protected_namespace "${ns}"; then
    warn "namespace protegido na lista de limpeza (ignorado): ${ns}"
    continue
  fi

  if namespace_exists "${ns}"; then
    log "Removendo namespace: ${ns}"
    kubectl delete namespace "${ns}" --wait=false
  else
    log "Namespace não encontrado (ok): ${ns}"
  fi
done

log "Aguardando finalização da remoção (timeout de 120s por namespace)..."
for ns in "${LAB_NAMESPACES[@]}"; do
  if is_protected_namespace "${ns}"; then
    continue
  fi

  if namespace_exists "${ns}"; then
    if kubectl wait --for=delete "namespace/${ns}" --timeout=120s >/dev/null 2>&1; then
      log "Namespace removido: ${ns}"
    else
      warn "namespace ${ns} ainda em remoção (Terminating) ou com finalizer."
    fi
  fi
done

log "Limpeza finalizada."
log "Namespaces do laboratório ainda existentes:"
FOUND_REMAINING=0
for ns in "${LAB_NAMESPACES[@]}"; do
  if namespace_exists "${ns}"; then
    echo "  - ${ns}"
    FOUND_REMAINING=1
  fi
done

if [[ "${FOUND_REMAINING}" -eq 0 ]]; then
  log "Nenhum namespace de laboratório pendente."
fi

log "Confirmação: processo de limpeza concluído com segurança."

# Observação de segurança:
# - Não deletar kube-system, default, kube-public ou kube-node-lease.
# - Não deletar cluster.
# - Não deletar kubeconfig.
exit 0
