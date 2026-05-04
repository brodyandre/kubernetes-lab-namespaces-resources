# 06 - LimitRange

## O que é LimitRange

`LimitRange` é um recurso do Kubernetes que define políticas de consumo por container dentro de um namespace.

Ele pode impor:

- valores padrão de request/limit
- valores mínimos permitidos
- valores máximos permitidos

## Como ele ajuda a definir valores padrão

Quando um pod é criado sem `resources`, o `LimitRange` pode aplicar automaticamente:

- `defaultRequest`: reserva mínima padrão
- `default`: limite máximo padrão

Isso evita workloads sem controle de recursos.

## Como ele impede consumo exagerado

Com `max`, o Kubernetes rejeita pods que tentam usar recursos acima do permitido.
Com `min`, ele também rejeita pods abaixo do mínimo definido por política.

Resultado: consumo mais previsível e menos risco de um pod degradar o namespace inteiro.

## Diferença entre default, defaultRequest, min e max

- `defaultRequest`: request padrão aplicado quando o pod não define request.
- `default`: limit padrão aplicado quando o pod não define limit.
- `min`: menor valor aceito por container.
- `max`: maior valor aceito por container.

## Por que usar LimitRange em namespaces compartilhados

Em namespaces com vários times e aplicações, o `LimitRange`:

- padroniza recursos mínimos e máximos
- reduz erro de configuração manual
- evita pods "sem limite" disputando recursos
- aumenta governança sem bloquear produtividade

## Manifests deste laboratório

- `manifests/limitrange/namespace-limitrange.yaml`
- `manifests/limitrange/limitrange-default.yaml`
- `manifests/limitrange/limitrange-min-max.yaml`
- `manifests/limitrange/pod-without-resources.yaml`
- `manifests/limitrange/pod-above-limit.yaml`

## Comandos

```bash
kubectl apply -f manifests/limitrange/
kubectl describe limitrange -n limitrange-lab
kubectl describe pod -n limitrange-lab pod-without-resources
kubectl apply -f manifests/limitrange/pod-above-limit.yaml
```

Observação importante:

O diretório `manifests/limitrange/` inclui o manifesto didático `pod-above-limit.yaml`.
Por isso, ao executar `kubectl apply -f manifests/limitrange/`, pode aparecer erro esperado de validação no final da execução.

Ao usar `scripts/apply-all.sh` ou `make apply`, esse arquivo didático **não** é aplicado automaticamente para evitar falha no fluxo principal.
Para reproduzir o erro de forma controlada, aplique manualmente `pod-above-limit.yaml`.

Leitura prática:

- `kubectl apply -f manifests/limitrange/`
Aplica namespace, políticas de `LimitRange` e pods; pode incluir erro esperado no manifesto de teste negativo.

- `kubectl describe limitrange -n limitrange-lab`
Mostra os valores configurados de `defaultRequest`, `default`, `min` e `max`.

- `kubectl describe pod -n limitrange-lab pod-without-resources`
Permite verificar os recursos efetivos aplicados ao `pod-without-resources`.

- `kubectl apply -f manifests/limitrange/pod-above-limit.yaml`
Tenta criar um pod acima do `max`; deve gerar erro de validação/controlador.

## Observação de comportamento esperado

O `pod-above-limit` deve falhar na criação ou validação, porque declara CPU e memória acima do limite máximo configurado no namespace.
