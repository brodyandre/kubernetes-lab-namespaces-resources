#!/usr/bin/env bash
set -euo pipefail

echo "[cleanup] Iniciando limpeza dos namespaces do laboratório..."

if ! command -v kubectl >/dev/null 2>&1; then
  echo "[cleanup] ERRO: kubectl não encontrado."
  exit 1
fi

NAMESPACES=(
  "dev"
  "staging"
  "prod"
  "backend"
  "frontend"
  "resources-lab"
  "qos-lab"
  "limitrange-lab"
  "quota-lab"
)

for ns in "${NAMESPACES[@]}"; do
  if kubectl get namespace "${ns}" >/dev/null 2>&1; then
    echo "[cleanup] Removendo namespace: ${ns}"
    kubectl delete namespace "${ns}" --wait=false
  else
    echo "[cleanup] Namespace não encontrado (ok): ${ns}"
  fi
done

echo "[cleanup] Aguardando finalização da remoção (timeout de 120s por namespace)..."
for ns in "${NAMESPACES[@]}"; do
  if kubectl get namespace "${ns}" >/dev/null 2>&1; then
    if kubectl wait --for=delete "namespace/${ns}" --timeout=120s >/dev/null 2>&1; then
      echo "[cleanup] Namespace removido: ${ns}"
    else
      echo "[cleanup] Aviso: namespace ${ns} ainda em remoção (Terminating) ou com finalizer."
    fi
  fi
done

echo "[cleanup] Limpeza finalizada."
echo "[cleanup] Namespaces ainda existentes entre os do laboratório:"
for ns in "${NAMESPACES[@]}"; do
  if kubectl get namespace "${ns}" >/dev/null 2>&1; then
    echo "[cleanup] - ${ns}"
  fi
done

echo "[cleanup] Confirmação: processo de limpeza concluído."
