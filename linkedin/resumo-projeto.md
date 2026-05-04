# Kubernetes Lab: Namespaces, Resources, QoS e Resource Quotas

## Resumo

Este projeto é um laboratório prático de Kubernetes voltado para consolidação de fundamentos essenciais de operação em ambientes Cloud Native.  
O objetivo é transformar teoria em prática com documentação técnica, manifests versionados e scripts de automação reproduzíveis.  
O conteúdo cobre organização por namespaces, comunicação interna via DNS, gestão de contextos com kubeconfig e governança de recursos.  
Também aborda requests/limits, classes de QoS, políticas de LimitRange e ResourceQuota em cenários reais de cluster compartilhado.  
A estrutura foi planejada para estudo progressivo, troubleshooting e apresentação profissional em portfólio técnico.  
O ambiente de execução prioriza ferramentas amplamente adotadas no mercado (Linux/WSL2, Docker, kubectl e Kubernetes local).  
O resultado é um repositório didático, prático e alinhado a demandas de times de Engenharia de Dados, DevOps e Cloud.  

## Competências demonstradas

- Kubernetes
- Docker
- Linux
- WSL2
- kubectl
- Infraestrutura como código
- Troubleshooting
- Documentação técnica
- Organização de repositório
- Boas práticas Cloud Native

## Destaques técnicos

- Separação por namespaces
- Comunicação interna via DNS
- Gerenciamento de contextos com kubeconfig
- Definição de requests e limits
- Classes de QoS
- Políticas de LimitRange
- Políticas de ResourceQuota
- Scripts de automação

## Evidências técnicas validadas

- Comunicação DNS entre namespaces validada com sucesso
- Pods rodando em múltiplos namespaces
- Metrics Server ativo
- QoS configurado e testável
- LimitRange aplicado
- ResourceQuota aplicado
- Scripts automatizados funcionando

## Como este projeto se conecta com Engenharia de Dados

Kubernetes é amplamente utilizado para orquestrar workloads de dados, APIs, pipelines, aplicações containerizadas, ferramentas de processamento e serviços em nuvem.  
Ao dominar isolamento por namespace, gestão de recursos e práticas de operação em cluster, o profissional de Engenharia de Dados ganha capacidade para construir plataformas mais estáveis, escaláveis e eficientes em ambientes modernos de dados.
