# Carrossel LinkedIn - Kubernetes Lab

## Tema

**Como transformei meus estudos de Kubernetes em um projeto prático no GitHub**

## Slide 1 - Capa

**Título curto**  
Da teoria para a prática com Kubernetes

**Texto principal**  
Transformei meus estudos em um laboratório real, documentado e versionado no GitHub, com foco em evolução técnica contínua.

**Sugestão visual**  
Tela inicial com título forte + fundo de terminal/VS Code + badges de Kubernetes, Docker e WSL2.

**Legenda curta**  
Meu laboratório prático de Kubernetes 🚀

## Slide 2 - O problema: estudar só teoria não basta

**Título curto**  
Só teoria não sustenta operação

**Texto principal**  
Aprender conceitos é importante, mas o ganho real vem quando você aplica comandos, valida erros e entende comportamento de cluster na prática.

**Sugestão visual**  
Divisão em duas colunas: “Teoria” x “Prática”, com checkmarks destacando execução real.

**Legenda curta**  
Foi aqui que decidi construir meu laboratório.

## Slide 3 - O laboratório criado

**Título curto**  
Estrutura profissional no GitHub

**Texto principal**  
Organizei o projeto com documentação por etapas, manifests Kubernetes, scripts de automação, Makefile, CI com GitHub Actions e templates de colaboração.

**Sugestão visual**  
Print da árvore do repositório no VS Code com destaque para `docs/`, `manifests/`, `scripts/` e `.github/`.

**Legenda curta**  
Não é só código: é organização técnica.

## Slide 4 - Namespaces e DNS interno

**Título curto**  
Isolamento e comunicação entre serviços

**Texto principal**  
Modelei ambientes com namespaces e validei comunicação interna via DNS Kubernetes, usando `backend-api.backend.svc.cluster.local`.

**Sugestão visual**  
Diagrama simples: `frontend-client` -> `Service backend-api` -> `Pod NGINX (backend)`.

**Legenda curta**  
Service discovery funcionando na prática ✅

## Slide 5 - Requests, Limits e QoS

**Título curto**  
Controle de CPU e memória

**Texto principal**  
Testei requests e limits para entender reserva mínima e teto de consumo, além das classes QoS (`Guaranteed`, `Burstable` e `BestEffort`).

**Sugestão visual**  
Tabela curta comparando requests/limits e as três classes QoS.

**Legenda curta**  
Governança de recursos desde o laboratório.

## Slide 6 - LimitRange e ResourceQuota

**Título curto**  
Políticas para ambientes compartilhados

**Texto principal**  
Configurei LimitRange para defaults/mínimos/máximos e ResourceQuota para limitar CPU, memória e objetos por namespace.

**Sugestão visual**  
Cards lado a lado: `LimitRange` (padrões) e `ResourceQuota` (limites totais do namespace).

**Legenda curta**  
Mais previsibilidade e menos surpresas em cluster.

## Slide 7 - Evidências reais no terminal

**Título curto**  
Validação prática, não só teoria

**Texto principal**  
O laboratório foi executado no cluster local e gerou evidências reais com `kubectl get`, `kubectl describe`, `kubectl top` e teste de DNS retornando “Welcome to nginx!”.

**Sugestão visual**  
Mosaico com 3 prints: namespaces, métricas e teste DNS entre namespaces.

**Legenda curta**  
Resultados reproduzíveis e documentados.

## Slide 8 - Convite para acessar o repositório

**Título curto**  
Vamos trocar aprendizados

**Texto principal**  
Se você também está evoluindo em Kubernetes, DevOps ou Cloud, acesse o projeto, use os materiais e compartilhe melhorias.

**Sugestão visual**  
Tela final com URL do GitHub + CTA “Acesse o repositório”.

**Legenda curta**  
Feedback técnico é sempre bem-vindo. 🤝

---

## Texto de apoio para legenda do post

Aprender Kubernetes na teoria foi importante, mas minha evolução acelerou quando transformei estudo em execução prática.

Criei um laboratório completo no GitHub com documentação, manifests, automações e validações reais de operação: namespaces, DNS interno, requests/limits, QoS, LimitRange e ResourceQuota.

Tudo em ambiente local com WSL2, Docker, kubectl e Kubernetes, com foco em consistência técnica e melhoria contínua.

Se fizer sentido para você, acesse o projeto e vamos trocar experiências sobre Kubernetes, DevOps e Cloud. 🚀
