# Contribuindo com o Projeto

## Visão geral

Obrigado por contribuir com o `kubernetes-lab-namespaces-resources`.

Este projeto é didático e prático, com foco em Kubernetes aplicado ao contexto de Engenharia de Dados, DevOps e Cloud. As contribuições devem manter clareza técnica, reprodutibilidade e qualidade de documentação.

## Como clonar o repositório

```bash
git clone https://github.com/brodyandre/kubernetes-lab-namespaces-resources.git
cd kubernetes-lab-namespaces-resources
```

## Como criar uma branch

Crie uma branch com nome descritivo:

```bash
git checkout -b feature/nome-da-melhoria
```

Sugestões de prefixo:

- `feature/` para novas funcionalidades
- `fix/` para correções
- `docs/` para melhorias de documentação
- `chore/` para tarefas de manutenção

## Como executar o laboratório

Use o Makefile para facilitar os testes locais:

```bash
make setup
make apply
make check
```

Se necessário, execute a limpeza:

```bash
make cleanup
```

## Como validar os manifests

Validação recomendada antes de abrir PR:

```bash
make check
```

Validação automática no GitHub:

- Workflow: `.github/workflows/validate-kubernetes-yaml.yml`
- Executa em `push` e `pull_request` para `main`
- Faz validação de sintaxe YAML e validação de manifests Kubernetes sem cluster externo

## Como abrir uma issue

1. Vá até a aba `Issues` do repositório.
2. Escolha o template adequado:
- `Bug report`
- `Melhoria`
- `Pergunta`
3. Preencha todas as seções com contexto técnico suficiente para reprodução ou análise.

Templates disponíveis em:

- `.github/ISSUE_TEMPLATE/bug_report.md`
- `.github/ISSUE_TEMPLATE/melhoria.md`
- `.github/ISSUE_TEMPLATE/pergunta.md`

## Como abrir um pull request

1. Faça suas alterações na branch criada.
2. Valide localmente (`make check`).
3. Faça commit e push.
4. Abra PR para a branch `main`.
5. Preencha o template de PR com resumo, tipo de mudança e evidências.

Template disponível em:

- `.github/pull_request_template.md`

## Padrão sugerido de commits

Use mensagens curtas, objetivas e no imperativo, seguindo padrão semântico simples.

Exemplos:

- `docs: improve kubernetes resources guide`
- `fix: adjust resourcequota example for quota-lab`
- `feat: add troubleshooting guide for namespace errors`
- `chore: update CI workflow for manifest validation`

## Fluxo rápido de contribuição (exemplo)

```bash
git clone https://github.com/brodyandre/kubernetes-lab-namespaces-resources.git
cd kubernetes-lab-namespaces-resources
git checkout -b feature/nome-da-melhoria
make setup
make apply
make check
git add .
git commit -m "docs: improve kubernetes resources guide"
git push origin feature/nome-da-melhoria
```

## Boas práticas para contribuição

- Mantenha o foco didático e prático do projeto.
- Não inclua segredos, tokens ou dados sensíveis.
- Evite alterações desnecessárias em arquivos não relacionados.
- Atualize documentação quando alterar comportamento de scripts ou manifests.
- Prefira mensagens de commit claras e pequenas mudanças por PR.
- Inclua evidências (comandos, saída resumida e screenshots reais, quando fizer sentido).
