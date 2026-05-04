# 09 - Publicando no GitHub

Este guia mostra, de forma simples e prática, como publicar este projeto no seu GitHub.

GitHub do autor:

`https://github.com/brodyandre`

Nome sugerido do repositório:

`kubernetes-lab-namespaces-resources`

## Opção 1: Publicar com Git (passo a passo)

No terminal, dentro da pasta do projeto, execute:

```bash
git init
git add .
git commit -m "docs: add professional kubernetes lab"
git branch -M main
git remote add origin https://github.com/brodyandre/kubernetes-lab-namespaces-resources.git
git push -u origin main
```

## Opção 2: Publicar com GitHub CLI

Se você já usa `gh` autenticado, pode criar e publicar com um único comando:

```bash
gh repo create brodyandre/kubernetes-lab-namespaces-resources --public --source=. --remote=origin --push
```

## Atenção: erro comum com remote

Se o repositório local já tiver `origin` configurado, o comando `git remote add origin ...` pode falhar.

Nesse caso, atualize a URL com:

```bash
git remote set-url origin https://github.com/brodyandre/kubernetes-lab-namespaces-resources.git
```

Depois, faça o push normalmente:

```bash
git push -u origin main
```

## Checklist rápido

- Você está na pasta correta do projeto
- O GitHub está acessível
- O token/sessão do GitHub CLI (se usar `gh`) está autenticado
- O branch local está em `main`
