#!/usr/bin/env bash
set -euo pipefail

echo "[check] Coletando status do cluster..."

if ! command -v kubectl >/dev/null 2>&1; then
  echo "[check] ERRO: kubectl não encontrado."
  exit 1
fi

echo
echo "[check] kubectl get namespaces"
kubectl get namespaces

echo
echo "[check] kubectl get pods -A"
kubectl get pods -A

echo
echo "[check] kubectl get svc -A"
kubectl get svc -A

echo
echo "[check] kubectl get resourcequota -A"
kubectl get resourcequota -A

echo
echo "[check] kubectl get limitrange -A"
kubectl get limitrange -A

echo
echo "[check] kubectl config current-context"
kubectl config current-context

echo
echo "[check] Sucesso: checagem concluída."
