# Usa bash para executar os alvos do laboratório.
SHELL := /bin/bash

# Torna "help" o alvo padrão quando "make" é executado sem argumentos.
.DEFAULT_GOAL := help

.PHONY: help setup apply check cleanup dns-test qos-test metrics quota limitrange status

help:
	@echo "Comandos disponíveis:"
	@echo "  make help        - Mostra todos os comandos disponíveis"
	@echo "  make setup       - Executa scripts/setup.sh"
	@echo "  make apply       - Executa scripts/apply-all.sh"
	@echo "  make check       - Executa scripts/check.sh"
	@echo "  make cleanup     - Executa scripts/cleanup.sh"
	@echo "  make status      - Mostra status geral do cluster"
	@echo "  make dns-test    - Testa DNS entre namespaces"
	@echo "  make qos-test    - Verifica classes QoS dos pods"
	@echo "  make metrics     - Mostra métricas de pods"
	@echo "  make quota       - Descreve ResourceQuota do namespace quota-lab"
	@echo "  make limitrange  - Descreve LimitRange do namespace limitrange-lab"

setup:
	@bash scripts/setup.sh

apply:
	@bash scripts/apply-all.sh

check:
	@bash scripts/check.sh

cleanup:
	@bash scripts/cleanup.sh

dns-test:
	@kubectl exec -n frontend -it frontend-client -- curl backend-api.backend.svc.cluster.local

qos-test:
	@kubectl describe pod pod-guaranteed -n qos-lab | grep -i "QoS Class"
	@kubectl describe pod pod-burstable -n qos-lab | grep -i "QoS Class"
	@kubectl describe pod pod-besteffort -n qos-lab | grep -i "QoS Class"

metrics:
	@kubectl top pods -A

quota:
	@kubectl describe quota -n quota-lab

limitrange:
	@kubectl describe limitrange -n limitrange-lab

status:
	@kubectl get namespaces
	@kubectl get pods -A
	@kubectl get svc -A
	@kubectl get resourcequota -A
	@kubectl get limitrange -A
