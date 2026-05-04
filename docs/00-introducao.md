# 00 - Introdução ao Kubernetes

## O que é Kubernetes

Kubernetes é uma plataforma de orquestração de contêineres. Em termos simples: se contêineres são "peças" de uma aplicação, o Kubernetes é o "sistema operacional" que organiza essas peças para rodarem com estabilidade em produção.

Ele cuida de tarefas como:

- publicação de aplicações
- escalabilidade
- recuperação automática de falhas
- descoberta de serviços
- gestão de CPU e memória

## Por que Kubernetes é importante

Aplicações modernas não rodam mais como um único bloco. Elas são compostas por vários serviços, filas, APIs e jobs. Gerenciar isso manualmente não escala.

Kubernetes se tornou importante porque padroniza como aplicações são executadas em diferentes ambientes, reduzindo dependência de configurações manuais e aumentando previsibilidade operacional.

Uma analogia útil: Docker empacota cada serviço como um "contêiner de carga"; Kubernetes funciona como o "porto inteligente" que decide onde cada contêiner fica, monitora falhas e redistribui carga quando necessário.

## Onde Kubernetes aparece no mundo real

Kubernetes é comum em:

- plataformas de e-commerce com picos de tráfego
- fintechs com requisitos de alta disponibilidade
- data platforms com pipelines e serviços de dados
- produtos SaaS multi-tenant
- ambientes híbridos (on-premises + cloud)

Na prática, ele aparece no bastidor de APIs, jobs de processamento, microsserviços e workloads de observabilidade.

## Relação com Docker e containers

- **Container**: unidade de execução da aplicação.
- **Docker**: ferramenta popular para build e execução local de contêineres.
- **Kubernetes**: orquestra múltiplos contêineres em um cluster.

Resumo prático: Docker ajuda a empacotar e testar; Kubernetes ajuda a operar em escala com resiliência.

## Por que estudar Kubernetes ajuda profissionais de dados, DevOps e Cloud

Para profissionais de **Dados**, Kubernetes facilita executar pipelines, jobs e serviços analíticos com isolamento e controle de recursos.

Para **DevOps**, é base para automação, confiabilidade e operação de aplicações em produção.

Para **Cloud**, é uma habilidade transversal: EKS, AKS, GKE e ambientes self-managed usam os mesmos conceitos centrais.

## Diferença entre teoria e prática

Na teoria, você entende conceitos como Pod, Service e Namespace.
Na prática, você enfrenta perguntas reais:

- por que o Pod não agendou?
- por que a aplicação não resolve DNS?
- por que o consumo de memória estourou?
- por que a quota bloqueou o deploy?

Este laboratório existe para preencher exatamente essa lacuna entre "saber o conceito" e "resolver o problema".

## Arquitetura geral do laboratório

```mermaid
flowchart LR
  A[Usuário] --> B[VS Code]
  B --> C[Terminal WSL2]
  C --> D[kubectl]
  D --> E[kubeconfig]
  E --> F[Cluster Kubernetes]
```

## Fluxo básico de operação

```mermaid
flowchart LR
  A[Usuário] --> B[kubectl]
  B --> C[API Server]
  C --> D[Cluster]
  D --> E[Pods]
```

## Como este laboratório está organizado

O projeto está dividido para aprendizado progressivo:

- `docs/`: explicações por tema, em sequência didática
- `manifests/`: YAMLs prontos para aplicar e testar
- `scripts/`: automação de setup, aplicação, checagem e limpeza
- `assets/`: diagramas e evidências visuais
- `linkedin/`: material de comunicação profissional do projeto

Objetivo final: aprender Kubernetes de forma prática, documentada e reaproveitável para portfólio técnico.
