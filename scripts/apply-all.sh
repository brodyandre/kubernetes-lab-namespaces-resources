#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="apply"

log() {
  echo "[${SCRIPT_NAME}] $*"
}

error() {
  echo "[${SCRIPT_NAME}] ERRO: $*" >&2
}

warn() {
  echo "[${SCRIPT_NAME}] ALERTA: $*"
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${REPO_ROOT}"

apply_if_exists() {
  local file="$1"
  if [[ -f "${file}" ]]; then
    log "Aplicando: ${file}"
    kubectl apply -f "${file}"
  else
    warn "Arquivo não encontrado (etapa ignorada): ${file}"
  fi
}

if ! command -v kubectl >/dev/null 2>&1; then
  error "kubectl não encontrado no PATH."
  exit 1
fi

if ! kubectl cluster-info >/dev/null 2>&1; then
  error "não foi possível acessar o cluster Kubernetes no contexto atual."
  exit 1
fi

log "Iniciando aplicação dos manifests do laboratório..."

log "Etapa 1/7: Criando namespaces (sempre antes dos objetos)"
apply_if_exists "manifests/namespaces/namespace-dev.yaml"
apply_if_exists "manifests/namespaces/namespace-staging.yaml"
apply_if_exists "manifests/namespaces/namespace-prod.yaml"
apply_if_exists "manifests/namespaces/namespace-qa.yaml"
apply_if_exists "manifests/namespaces/namespace-shared.yaml"
apply_if_exists "manifests/dns-cross-namespace/backend-namespace.yaml"
apply_if_exists "manifests/dns-cross-namespace/frontend-namespace.yaml"
apply_if_exists "manifests/qos/namespace-qos.yaml"
apply_if_exists "manifests/limitrange/namespace-limitrange.yaml"
apply_if_exists "manifests/resourcequota/namespace-quota.yaml"

log "Etapa 2/7: Aplicando objetos do namespace dev"
apply_if_exists "manifests/namespaces/app-dev.yaml"
apply_if_exists "manifests/namespaces/service-dev.yaml"

log "Etapa 3/7: Aplicando laboratório de DNS entre namespaces"
apply_if_exists "manifests/dns-cross-namespace/backend-deployment.yaml"
apply_if_exists "manifests/dns-cross-namespace/backend-service.yaml"
apply_if_exists "manifests/dns-cross-namespace/frontend-pod.yaml"

log "Etapa 4/7: Aplicando laboratório de resources, requests e limits"
log "Observação: o manifesto app-with-requests-limits.yaml já inclui a criação do namespace resources-lab."
apply_if_exists "manifests/resources/app-with-requests-limits.yaml"
apply_if_exists "manifests/resources/stress-pod.yaml"

log "Etapa 5/7: Aplicando laboratório de QoS"
apply_if_exists "manifests/qos/pod-guaranteed.yaml"
apply_if_exists "manifests/qos/pod-burstable.yaml"
apply_if_exists "manifests/qos/pod-besteffort.yaml"

log "Etapa 6/7: Aplicando laboratório de LimitRange"
apply_if_exists "manifests/limitrange/limitrange-default.yaml"
apply_if_exists "manifests/limitrange/limitrange-min-max.yaml"
apply_if_exists "manifests/limitrange/pod-without-resources.yaml"
log "Arquivo didático não aplicado automaticamente: manifests/limitrange/pod-above-limit.yaml"

log "Etapa 7/7: Aplicando laboratório de ResourceQuota"
apply_if_exists "manifests/resourcequota/resourcequota-compute.yaml"
apply_if_exists "manifests/resourcequota/resourcequota-objects.yaml"
apply_if_exists "manifests/resourcequota/deployment-with-quota.yaml"
log "Arquivo didático não aplicado automaticamente: manifests/resourcequota/deployment-exceed-quota.yaml"

log "Aplicação concluída com sucesso."
