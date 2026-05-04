#!/usr/bin/env bash
set -euo pipefail

echo "[setup] Iniciando verificações do ambiente Kubernetes..."

if ! command -v kubectl >/dev/null 2>&1; then
  echo "[setup] ERRO: kubectl não está instalado."
  exit 1
fi
echo "[setup] OK: kubectl encontrado."

if ! command -v docker >/dev/null 2>&1; then
  echo "[setup] ERRO: docker não está instalado."
  exit 1
fi
echo "[setup] OK: docker encontrado."

if ! kubectl cluster-info >/dev/null 2>&1; then
  echo "[setup] ERRO: não foi encontrado um cluster Kubernetes acessível no contexto atual."
  echo "[setup] Dica: verifique seu contexto com 'kubectl config get-contexts'."
  exit 1
fi
echo "[setup] OK: cluster Kubernetes acessível."

CURRENT_CONTEXT="$(kubectl config current-context 2>/dev/null || true)"
if [[ -z "${CURRENT_CONTEXT}" ]]; then
  echo "[setup] ERRO: não foi possível identificar o contexto atual."
  exit 1
fi

CURRENT_NAMESPACE="$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null || true)"
if [[ -z "${CURRENT_NAMESPACE}" ]]; then
  CURRENT_NAMESPACE="default"
fi

echo "[setup] Contexto atual: ${CURRENT_CONTEXT}"
echo "[setup] Namespace atual: ${CURRENT_NAMESPACE}"
echo "[setup] Sucesso: ambiente pronto para aplicar os manifests do laboratório."
