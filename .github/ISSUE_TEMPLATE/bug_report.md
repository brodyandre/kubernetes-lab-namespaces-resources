---
name: Bug report
about: Reportar erro, falha ou comportamento inesperado no laboratório.
title: "bug: descrição curta do problema"
labels: bug
assignees: ""
---

## Título sugerido

`bug: erro ao aplicar manifests no namespace X`

## Descrição do problema

Descreva de forma clara o que aconteceu, em qual etapa e qual impacto no laboratório.

## Passos para reproduzir

1. Execute `...`
2. Aplique `...`
3. Rode `...`
4. Observe o erro

## Resultado esperado

Descreva o comportamento esperado.

## Resultado obtido

Descreva o comportamento real observado.

## Ambiente

- Sistema operacional:
- WSL2 (sim/não):
- Distribuição Linux:
- Versão do `kubectl`:
- Contexto atual (`kubectl config current-context`):
- Provisionador local (`kind`, `k3d`, `minikube`):

## Logs relevantes

Cole saídas úteis, por exemplo:

```bash
kubectl get pods -A
kubectl describe pod NOME -n NAMESPACE
kubectl logs NOME -n NAMESPACE
```
