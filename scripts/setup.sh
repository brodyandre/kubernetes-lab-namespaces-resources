#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="setup"

log() {
  echo "[${SCRIPT_NAME}] $*"
}

error() {
  echo "[${SCRIPT_NAME}] ERRO: $*" >&2
}

warn() {
  echo "[${SCRIPT_NAME}] ALERTA: $*"
}

log "Iniciando verificações do ambiente Kubernetes..."

if ! command -v kubectl >/dev/null 2>&1; then
  error "kubectl não está instalado ou não está no PATH."
  exit 1
fi
log "OK: kubectl encontrado."

if ! command -v docker >/dev/null 2>&1; then
  error "docker não está instalado ou não está no PATH."
  exit 1
fi
log "OK: docker encontrado."

if ! kubectl cluster-info >/dev/null 2>&1; then
  error "não foi encontrado um cluster Kubernetes acessível no contexto atual."
  log "Dica: verifique com 'kubectl config get-contexts' e 'kubectl config current-context'."
  exit 1
fi
log "OK: cluster Kubernetes acessível."

CURRENT_CONTEXT="$(kubectl config current-context 2>/dev/null || true)"
if [[ -z "${CURRENT_CONTEXT}" ]]; then
  error "não foi possível identificar o contexto atual."
  exit 1
fi

CURRENT_NAMESPACE="$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null || true)"
if [[ -z "${CURRENT_NAMESPACE}" ]]; then
  CURRENT_NAMESPACE="default"
fi

log "Contexto atual: ${CURRENT_CONTEXT}"
log "Namespace atual: ${CURRENT_NAMESPACE}"

if [[ "${CURRENT_CONTEXT}" != *kind* && "${CURRENT_CONTEXT}" != *minikube* ]]; then
  warn "o contexto atual não contém 'kind' nem 'minikube'. Confirme se está usando o cluster correto."
fi

log "Sucesso: ambiente pronto para aplicar os manifests do laboratório."
