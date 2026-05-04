#!/bin/bash

set -e

echo "[apply] Iniciando aplicação dos manifests..."

echo "[apply] ----------------------------------------"
echo "[apply] Etapa 1: Criando namespaces principais"

kubectl apply -f manifests/namespaces/namespace-dev.yaml
kubectl apply -f manifests/namespaces/namespace-staging.yaml
kubectl apply -f manifests/namespaces/namespace-prod.yaml

if [ -f manifests/namespaces/namespace-qa.yaml ]; then
  kubectl apply -f manifests/namespaces/namespace-qa.yaml
fi

if [ -f manifests/namespaces/namespace-shared.yaml ]; then
  kubectl apply -f manifests/namespaces/namespace-shared.yaml
fi

kubectl apply -f manifests/dns-cross-namespace/backend-namespace.yaml
kubectl apply -f manifests/dns-cross-namespace/frontend-namespace.yaml

if [ -f manifests/qos/namespace-qos.yaml ]; then
  kubectl apply -f manifests/qos/namespace-qos.yaml
fi

if [ -f manifests/limitrange/namespace-limitrange.yaml ]; then
  kubectl apply -f manifests/limitrange/namespace-limitrange.yaml
fi

if [ -f manifests/resourcequota/namespace-quota.yaml ]; then
  kubectl apply -f manifests/resourcequota/namespace-quota.yaml
fi

echo "[apply] ----------------------------------------"
echo "[apply] Etapa 2: Aplicando objetos do namespace dev"

kubectl apply -f manifests/namespaces/app-dev.yaml
kubectl apply -f manifests/namespaces/service-dev.yaml

echo "[apply] ----------------------------------------"
echo "[apply] Etapa 3: Aplicando laboratório de DNS entre namespaces"

kubectl apply -f manifests/dns-cross-namespace/backend-deployment.yaml
kubectl apply -f manifests/dns-cross-namespace/backend-service.yaml
kubectl apply -f manifests/dns-cross-namespace/frontend-pod.yaml

echo "[apply] ----------------------------------------"
echo "[apply] Etapa 4: Aplicando laboratório de Resources, Requests e Limits"

kubectl apply -f manifests/resources/app-with-requests-limits.yaml

if [ -f manifests/resources/stress-pod.yaml ]; then
  kubectl apply -f manifests/resources/stress-pod.yaml
fi

echo "[apply] ----------------------------------------"
echo "[apply] Etapa 5: Aplicando laboratório de QoS"

kubectl apply -f manifests/qos/pod-guaranteed.yaml
kubectl apply -f manifests/qos/pod-burstable.yaml
kubectl apply -f manifests/qos/pod-besteffort.yaml

echo "[apply] ----------------------------------------"
echo "[apply] Etapa 6: Aplicando laboratório de LimitRange"

kubectl apply -f manifests/limitrange/limitrange-default.yaml
kubectl apply -f manifests/limitrange/limitrange-min-max.yaml
kubectl apply -f manifests/limitrange/pod-without-resources.yaml

echo "[apply] ----------------------------------------"
echo "[apply] Etapa 7: Aplicando laboratório de ResourceQuota"

kubectl apply -f manifests/resourcequota/resourcequota-compute.yaml
kubectl apply -f manifests/resourcequota/resourcequota-objects.yaml
kubectl apply -f manifests/resourcequota/deployment-with-quota.yaml

echo "[apply] ----------------------------------------"
echo "[apply] Aplicação concluída com sucesso."
