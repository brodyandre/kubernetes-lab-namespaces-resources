# 08 - Boas Práticas em Kubernetes

Este guia reúne práticas profissionais para operar Kubernetes com segurança, previsibilidade e clareza técnica.

## 1. Sempre usar namespaces para separar ambientes ou times

- Explicação: namespaces isolam workloads por contexto (ex.: time, produto ou ambiente), facilitando governança e operação.
- Exemplo prático: criar `dev`, `staging` e `prod`, ou `time-a` e `time-b`, com políticas próprias.
- Risco de não aplicar: mistura de recursos, conflito de nomes e maior chance de mudança indevida em ambiente crítico.

## 2. Definir requests e limits em workloads

- Explicação: `requests` garantem reserva mínima; `limits` controlam teto máximo de consumo.
- Exemplo prático: em um Deployment, usar `requests.cpu: 100m`, `requests.memory: 128Mi`, `limits.cpu: 500m`, `limits.memory: 256Mi`.
- Risco de não aplicar: competição descontrolada por recursos, instabilidade de pods e baixa previsibilidade de performance.

## 3. Usar ResourceQuota em namespaces compartilhados

- Explicação: `ResourceQuota` limita consumo total de recursos e quantidade de objetos no namespace.
- Exemplo prático: definir quotas para `requests.cpu`, `limits.memory`, `pods`, `services` e `secrets`.
- Risco de não aplicar: um único time pode consumir capacidade excessiva e impactar os demais.

## 4. Usar LimitRange para aplicar padrões mínimos

- Explicação: `LimitRange` impõe mínimos, máximos e padrões (`default` e `defaultRequest`) por container.
- Exemplo prático: configurar `defaultRequest` para CPU/memória em namespace de desenvolvimento.
- Risco de não aplicar: pods sem recursos definidos e configurações fora de padrão operacional.

## 5. Evitar usar namespace default em projetos reais

- Explicação: `default` deve ser evitado para workloads de projeto, pois não comunica escopo nem ambiente.
- Exemplo prático: criar namespace dedicado para cada aplicação e manter `default` apenas para testes rápidos.
- Risco de não aplicar: baixa rastreabilidade, organização fraca e aumento de erro humano.

## 6. Nomear recursos de forma clara

- Explicação: nomes consistentes facilitam manutenção, observabilidade e troubleshooting.
- Exemplo prático: usar `api-pagamentos`, `worker-etl`, `frontend-web` em vez de nomes genéricos como `app1`.
- Risco de não aplicar: dificuldade para identificar recursos em incidentes e operações mais lentas.

## 7. Usar labels consistentes

- Explicação: labels permitem seleção, agrupamento e automação de recursos.
- Exemplo prático: padronizar `app`, `team`, `environment` e `version` em Deployments, Pods e Services.
- Risco de não aplicar: seletores inconsistentes, falhas em Service discovery e baixa qualidade de observabilidade.

## 8. Versionar manifests no GitHub

- Explicação: versionamento cria histórico auditável e melhora colaboração entre times.
- Exemplo prático: abrir Pull Requests para mudanças em YAML com revisão obrigatória.
- Risco de não aplicar: alterações sem rastreabilidade, rollback difícil e maior risco operacional.

## 9. Documentar comandos importantes

- Explicação: comandos documentados aceleram onboarding e padronizam execução.
- Exemplo prático: manter comandos de setup, apply, check e cleanup em `README` e `docs/`.
- Risco de não aplicar: conhecimento concentrado em poucas pessoas e execução inconsistente.

## 10. Usar kubectl describe para troubleshooting

- Explicação: `kubectl describe` mostra eventos e detalhes críticos de recursos.
- Exemplo prático: `kubectl describe pod <nome> -n <namespace>` para investigar erros de agendamento ou imagem.
- Risco de não aplicar: diagnóstico superficial e demora para identificar causa raiz.

## 11. Verificar contexto atual antes de aplicar manifests

- Explicação: o contexto define em qual cluster e credencial os comandos serão executados.
- Exemplo prático: sempre executar `kubectl config current-context` antes de `kubectl apply`.
- Risco de não aplicar: deploy no cluster errado e impacto em ambientes não planejados.

## 12. Ter cuidado ao trabalhar com múltiplos clusters

- Explicação: operar vários clusters exige disciplina para não cruzar mudanças entre ambientes.
- Exemplo prático: usar nomes de contexto claros como `kind-dev`, `staging-eks`, `prod-eks`.
- Risco de não aplicar: alterações em ambiente incorreto, incidentes e retrabalho operacional.

## 13. Usar kubectx e kubens para reduzir erros operacionais

- Explicação: essas ferramentas tornam a troca de contexto e namespace mais rápida e visível.
- Exemplo prático: `kubectx prod-eks` e `kubens pagamentos` antes de comandos críticos.
- Risco de não aplicar: maior chance de executar comandos no namespace/contexto errado.

## 14. Nunca aplicar YAML em produção sem revisar namespace e contexto

- Explicação: revisão prévia reduz riscos de aplicar mudanças fora do escopo esperado.
- Exemplo prático: checklist antes do deploy: contexto atual, namespace alvo, diff da mudança e impacto.
- Risco de não aplicar: indisponibilidade, rollback emergencial e perda de confiança no processo.

## 15. Manter evidências do laboratório com screenshots

- Explicação: evidências comprovam execução prática e ajudam em documentação técnica e portfólio.
- Exemplo prático: salvar prints de `kubectl get`, `kubectl describe`, quotas e métricas em `assets/screenshots/`.
- Risco de não aplicar: menor comprovação de experiência prática para recrutadores e equipes técnicas.
