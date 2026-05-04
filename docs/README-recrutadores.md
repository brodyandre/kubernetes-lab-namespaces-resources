# Resumo Executivo para Recrutadores

## Nome do projeto

**Kubernetes Lab: Namespaces, Resources, QoS e Resource Quotas**

## Objetivo (até 5 linhas)

Este projeto transforma estudos de Kubernetes em prática real e documentada.  
Ele demonstra criação de ambientes isolados por namespace, comunicação interna via DNS e controle de recursos com políticas de governança.  
A proposta é mostrar execução técnica reproduzível, com automações, validações e troubleshooting.  
Todo o conteúdo foi estruturado para estudo progressivo e apresentação profissional em portfólio.

## Por que este projeto é relevante

- Mostra experiência prática, não apenas teoria.
- Simula cenários comuns de times de plataforma, DevOps e Cloud.
- Evidencia organização técnica, disciplina operacional e clareza de documentação.

## Competências demonstradas

- Kubernetes (namespaces, services, DNS, QoS, LimitRange, ResourceQuota)
- Linux/WSL2 e operação com `kubectl`
- Infraestrutura como código (manifests YAML)
- Automação com scripts e Makefile
- Troubleshooting e validação de ambiente
- Documentação técnica para colaboração

## Como o projeto foi testado

- Execução local em cluster Kubernetes (`kind`)
- Verificações com `kubectl get`, `kubectl describe`, `kubectl top` e testes de DNS entre namespaces
- Validação automática de YAML/manifests com GitHub Actions (`yamllint` e `kubeconform`)

## Tecnologias usadas

- Kubernetes
- Docker
- Kind
- kubectl
- Linux (Ubuntu no WSL2)
- Git e GitHub
- GitHub Actions

## Relação com Engenharia de Dados

Kubernetes é amplamente usado para orquestrar APIs, pipelines, jobs e serviços de dados.  
Este laboratório demonstra fundamentos essenciais para operar workloads de dados com isolamento, previsibilidade de recursos e práticas de produção.

## Links úteis

- README principal: [../README.md](../README.md)
- Perfil do autor (LinkedIn): https://www.linkedin.com/in/luiz-andre-souza-data-engineer/
