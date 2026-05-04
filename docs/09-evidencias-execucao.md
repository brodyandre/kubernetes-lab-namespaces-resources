# 09 - Evidências de Execução do Laboratório

## Objetivo da validação

Documentar, de forma prática e verificável, que os principais cenários do laboratório Kubernetes foram executados com sucesso no ambiente local.

O foco desta validação é demonstrar:

- comunicação entre namespaces
- governança de recursos
- observabilidade básica
- operação orientada a contexto e automação

## Ambiente utilizado

- Cluster: `kind-lab-ns-res`
- Sistema operacional host: Windows 11
- Camada Linux: WSL2 + Ubuntu
- Ferramentas: Docker, Kind, kubectl, VS Code

## Validação 1: cluster ativo e acessível

### Comando executado

```bash
kubectl config current-context
kubectl cluster-info
```

### Resultado esperado

- contexto ativo apontando para o cluster do laboratório
- API Server acessível

### Explicação técnica simples

Sem contexto correto e acesso ao API Server, nenhum manifesto pode ser aplicado com segurança.

## Validação 2: namespaces de isolamento criados

### Comando executado

```bash
kubectl get namespaces
```

### Resultado esperado

Presença dos namespaces de estudo:

- `dev`, `staging`, `prod`, `qa`, `shared`
- `backend`, `frontend`
- `resources-lab`, `qos-lab`, `limitrange-lab`, `quota-lab`

### Explicação técnica simples

Namespaces permitem separar workloads e políticas por ambiente/time, reduzindo risco operacional.

## Validação 3: comunicação DNS entre namespaces

### Comando executado

```bash
kubectl exec -n frontend -it frontend-client -- curl backend-api.backend.svc.cluster.local
```

### Resultado esperado

Retorno da página padrão do NGINX contendo:

`Welcome to nginx!`

### Explicação técnica simples

O pod `frontend-client` resolveu o DNS interno completo e acessou o Service `backend-api` no namespace `backend`, comprovando:

- service discovery funcional
- DNS interno funcional
- comunicação cross-namespace funcional
- Service ClusterIP funcional

Fluxo:

`frontend-client` -> `backend-api.backend.svc.cluster.local` -> Service `backend-api` -> Pod NGINX (`backend`)

## Validação 4: classes de QoS

### Comandos executados

```bash
kubectl describe pod pod-guaranteed -n qos-lab | grep -i "QoS Class"
kubectl describe pod pod-burstable -n qos-lab | grep -i "QoS Class"
kubectl describe pod pod-besteffort -n qos-lab | grep -i "QoS Class"
```

### Resultado esperado

- `QoS Class: Guaranteed`
- `QoS Class: Burstable`
- `QoS Class: BestEffort`

### Explicação técnica simples

As classes de QoS confirmam como o Kubernetes prioriza pods sob pressão de recursos:

- Guaranteed: requests e limits iguais
- Burstable: requests e limits definidos, porém diferentes
- BestEffort: sem requests e sem limits

## Validação 5: políticas de ResourceQuota e LimitRange

### Comandos executados

```bash
kubectl get resourcequota -A
kubectl get limitrange -A
kubectl describe quota -n quota-lab
kubectl describe limitrange -n limitrange-lab
```

### Resultado esperado

- quotas visíveis e contabilizando `Used` vs `Hard`
- limitranges ativos com regras de `default`, `defaultRequest`, `min` e `max`

### Explicação técnica simples

Essas políticas controlam o uso de recursos por namespace e evitam consumo descontrolado em ambientes compartilhados.

## Validação 6: métricas de recursos (Metrics Server)

### Comando executado

```bash
kubectl top pods -A
```

### Resultado esperado

Listagem de pods com consumo atual de CPU e memória.

### Explicação técnica simples

`kubectl top` depende de Metrics Server e comprova coleta de métricas operacionais básicas.

## Evidências visuais (screenshots)

Adicione prints reais em `assets/screenshots/` para reforçar a comprovação prática.

Sugestões:

- `kubectl get namespaces`
- `kubectl get pods -A`
- `kubectl get svc -A`
- `kubectl describe quota -n quota-lab`
- `kubectl describe limitrange -n limitrange-lab`
- `kubectl top pods -A`
- VS Code com estrutura do repositório
- README renderizado no GitHub

## Por que essa validação é importante em ambientes reais

Em ambientes reais de Kubernetes, validar execução prática é essencial para reduzir risco de produção.
As evidências acima demonstram não apenas conhecimento teórico, mas capacidade de operar cluster, diagnosticar comportamento, aplicar políticas de governança e confirmar conectividade entre serviços.

Esse tipo de validação é altamente relevante para times de Engenharia de Dados, DevOps e Cloud que operam workloads distribuídos em produção.
