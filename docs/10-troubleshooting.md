# 10. Troubleshooting

## Objetivo

Documentar erros comuns que podem acontecer durante a execução deste laboratório Kubernetes e como resolver cada um de forma prática.

## 1. Erro: `namespace not found`

**Causa**  
O manifesto tentou criar um Deployment, Pod ou Service antes do Namespace existir.

**Solução**

1. Aplique primeiro o namespace correspondente.
2. Depois, aplique os objetos desse namespace.

Exemplo:

```bash
kubectl apply -f manifests/namespaces/namespace-dev.yaml
kubectl apply -f manifests/namespaces/app-dev.yaml
kubectl apply -f manifests/namespaces/service-dev.yaml
```

## 2. Erro: `ImagePullBackOff`

**Causa**  
Imagem inexistente, nome errado ou problema de acesso ao registry.

**Solução**

1. Verifique o nome da imagem no YAML.
2. Inspecione o Pod para ver a mensagem completa do erro:

```bash
kubectl describe pod NOME_DO_POD -n NAMESPACE
```

## 3. Erro: Pod `Pending`

**Causa**  
Falta de recursos no nó, problema de scheduling ou bloqueio por quota.

**Solução**

```bash
kubectl describe pod NOME -n NAMESPACE
```

Dica: confira a seção `Events` no final do `describe` para identificar a causa exata.

## 4. Erro: `ResourceQuota exceeded`

**Causa**  
O namespace atingiu limite de CPU, memória, pods ou objetos.

**Solução**

```bash
kubectl describe quota -n quota-lab
```

Depois, ajuste requests/limits, reduza réplicas ou remova recursos não utilizados.

## 5. Erro: `LimitRange validation failed`

**Causa**  
O Pod tentou criar request ou limit fora dos valores mínimos e máximos permitidos no namespace.

**Solução**

```bash
kubectl describe limitrange -n limitrange-lab
```

Revise os valores de `resources.requests` e `resources.limits` no manifesto antes de reaplicar.

## 6. Erro: `kubectl top pods` não funciona

**Causa**  
Metrics Server ausente, com falha, ou ainda inicializando.

**Solução**

```bash
kubectl get pods -n kube-system
kubectl get deployment metrics-server -n kube-system
```

Se o Metrics Server não estiver `Available`, aguarde inicializar ou revise a instalação no cluster local.

## 7. Erro: DNS entre namespaces não funciona

**Causa**  
Service inexistente, namespace errado ou DNS digitado incorretamente.

**Solução**

```bash
kubectl get svc -n backend
kubectl get pods -n backend
kubectl exec -n frontend -it frontend-client -- nslookup backend-api.backend.svc.cluster.local
```

Confirme se o Service `backend-api` existe e aponta para Pods saudáveis no namespace `backend`.

## Comandos úteis para diagnóstico

```bash
kubectl get pods -A
kubectl describe pod NOME_DO_POD -n NAMESPACE
kubectl logs NOME_DO_POD -n NAMESPACE
kubectl get events -A
kubectl config current-context
```

## Boas práticas de troubleshooting

- Sempre valide o contexto atual antes de aplicar manifests.
- Leia os `Events` de Pods e Namespaces ao investigar falhas.
- Isolar problemas por namespace acelera a análise.
- Registre evidências dos erros e das correções em `assets/screenshots/`.
