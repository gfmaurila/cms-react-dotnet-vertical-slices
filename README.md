# CMS .NET + React + MySQL — Harness

Harness para geração de um CMS evolutivo usando **C#/.NET 10, ASP.NET Core Minimal APIs, Vertical Slices, CQRS, Domain Events, EF Core/Migrations, MySQL e React/Vite/TypeScript**.

## Arquitetura

```text
React
├── Site
└── Admin
     │
     ▼
Cms.Api
├── /api/auth
├── /api/admin
└── /api/site
     │
     ▼
EF Core + Migrations
     │
     ▼
MySQL
```

O projeto utiliza **uma API** e **uma aplicação React**. O React é organizado em dois módulos principais: `site` e `admin`.

Não são utilizados Plugins ou Themes. A interface evolui conforme novas telas, screenshots, layouts e tasks forem adicionados.

## Como usar

Use `PROJECT.md` como especificação principal para o agente de IA. O agente deve gerar as pastas `backend`, `frontend`, `tasks`, `screenshots`, `layouts`, `requirements`, configurações de ambiente e `docker-compose.yml` durante a execução.

## Stack alvo

- .NET 10 / C#
- ASP.NET Core Minimal APIs
- Vertical Slices
- CQRS
- Domain Events
- Entity Framework Core
- EF Core Migrations
- MySQL
- JWT + Refresh Token
- Roles + Permissions
- React
- Vite
- TypeScript
- Docker / Docker Compose

## Evolução

Novas funcionalidades devem ser solicitadas através de tasks. Quando houver uma nova tela, a referência visual pode ser adicionada em `screenshots/` ou `layouts/`, e a task deve informar o comportamento esperado.

O agente deverá implementar somente o necessário para aquela evolução, incluindo frontend, API, EF Core Migration e testes quando aplicável.


## Credenciais DEV obrigatórias

O projeto gerado deve criar via seed estas contas de demonstração no ambiente DEV:

| Perfil | Login | Senha | Uso |
|---|---|---|---|
| Admin | `admin@cms.local` | `CmsAdmin@2026!` | Administração completa |
| Editor | `editor@cms.local` | `CmsEditor@2026!` | Gestão de conteúdo |
| Leitor | `leitor@cms.local` | `CmsLeitor@2026!` | Consulta autenticada |
| Visitante | `visitante@cms.local` | `CmsVisitante@2026!` | Perfil básico |

As senhas acima são exclusivamente para desenvolvimento/demonstração. No banco, devem ser persistidas apenas como hash. HML e PROD devem usar credenciais seguras fornecidas por configuração/secret e não devem depender dessas senhas fixas.

## Conteúdo inicial obrigatório

A geração inicial deve entregar um site institucional completo e navegável, alimentado pelo MySQL via API: Home, Sobre, Serviços, Notícias, Contato, menus, rodapé, configurações institucionais, categorias e pelo menos três notícias de exemplo. O Admin deve permitir gerenciar esse conteúdo conforme as permissões de cada perfil.

## Estimativa de consumo de IA para gerar o projeto completo

> Estimativa de planejamento, não um valor garantido. O consumo real depende do agente/modelo, número de iterações, correções, testes, quantidade de arquivos relidos e uso de cache.

A estimativa considera a geração completa de: API .NET, React Site + Admin, autenticação, usuários/roles/permissões, MySQL, EF Core Migrations, seeds, site institucional, CRUDs administrativos, Docker, testes e documentação.

### Faixa estimada de tokens

| Cenário | Tokens de entrada | Tokens de saída | Total aproximado | Quando ocorre |
|---|---:|---:|---:|---|
| Econômico | 1.000.000 | 500.000 | 1.500.000 | Geração direta, poucas correções e bom reaproveitamento de contexto |
| Provável | 2.500.000 | 1.000.000 | 3.500.000 | Geração + build + migrations + testes + correções |
| Alto | 5.000.000 | 2.000.000 | 7.000.000 | Muitas iterações, releitura de arquivos e correções completas |

### Estimativa de custo — GPT-5.6 Sol

Referência em 17/09/2026: US$ 4,00 / 1M tokens de entrada, US$ 0,40 / 1M de entrada em cache e US$ 20,00 / 1M tokens de saída. Para conversão ilustrativa foi usado US$ 1 = R$ 5,1557.

| Cenário | Custo entrada | Custo saída | Total USD | Total aproximado BRL |
|---|---:|---:|---:|---:|
| Econômico | US$ 4,00 | US$ 10,00 | **US$ 14,00** | **R$ 72,18** |
| Provável | US$ 10,00 | US$ 20,00 | **US$ 30,00** | **R$ 154,67** |
| Alto | US$ 20,00 | US$ 40,00 | **US$ 60,00** | **R$ 309,34** |

O cenário **Provável** deve ser usado como orçamento inicial para uma geração completa. Cache de contexto pode reduzir o custo de entrada; novas telas, novas funcionalidades e refatorações posteriores não estão incluídas nessa estimativa.

### Estimativa de tempo

| Etapa | Tempo estimado |
|---|---:|
| Estrutura + Backend | 15–30 min |
| React Site + Admin | 15–30 min |
| Migrations + Seeds + MySQL | 5–15 min |
| Docker + integração | 5–15 min |
| Testes + correções | 15–30 min |
| **Total esperado** | **55–120 min** |

### Fórmula para recalcular

```text
Custo USD =
(tokens_entrada / 1.000.000 × preço_entrada) +
(tokens_cache / 1.000.000 × preço_cache) +
(tokens_saida / 1.000.000 × preço_saida)

Custo BRL = Custo USD × cotação USD/BRL
```

Antes de iniciar a geração, o agente deve tratar estes números apenas como referência e registrar no relatório final o consumo real, quando a ferramenta utilizada disponibilizar métricas de tokens/custo.



## Continuidade quando o limite de tokens for atingido

A geração deve ser executada de forma incremental e recuperável. O agente **não pode depender exclusivamente do contexto da conversa** para saber o estado do projeto.

Durante a execução, deve manter atualizado o diretório:

```text
tasks/progress/
├── PROJECT_STATUS.md
├── COMPLETED_TASKS.md
├── PENDING_TASKS.md
├── CONTINUATION_PROMPT.md
└── TOKEN_ESTIMATE.md
```

### Checkpoint obrigatório

Após cada etapa relevante (estrutura, banco, autenticação, Admin, Site, Docker, testes etc.), atualizar os arquivos de progresso. Se a ferramenta indicar que o limite de tokens/contexto/créditos está próximo, o agente deve **interromper novas implementações com segurança**, salvar o estado atual e produzir um checkpoint antes de encerrar.

`PROJECT_STATUS.md` deve registrar:
- data/hora do checkpoint;
- etapa atual;
- percentual aproximado concluído;
- último arquivo/feature trabalhado;
- builds, migrations e testes executados e seus resultados;
- erros conhecidos;
- decisões arquiteturais já tomadas;
- comandos necessários para validar o estado atual.

`COMPLETED_TASKS.md` deve listar objetivamente tudo que já foi implementado e validado, evitando que outro agente refaça trabalho concluído.

`PENDING_TASKS.md` deve conter, em ordem recomendada de execução:
- item pendente;
- prioridade;
- arquivos/features envolvidos;
- dependências;
- critério de aceite;
- estimativa de tokens para concluir o item.

`TOKEN_ESTIMATE.md` deve apresentar:

| Item | Tokens estimados restantes | Observação |
|---|---:|---|
| Backend pendente | ... | ... |
| Frontend pendente | ... | ... |
| Migrations/Seeds | ... | ... |
| Docker/Integração | ... | ... |
| Testes/Correções | ... | ... |
| Documentação | ... | ... |
| **Total estimado restante** | **...** | |

Se a plataforma fornecer métricas reais de tokens consumidos/restantes, elas devem ser registradas separadamente. Se não fornecer, o agente **não deve inventar um saldo real**: deve identificar os números como estimativas calculadas a partir do trabalho pendente.

`CONTINUATION_PROMPT.md` deve ser autocontido e pronto para copiar em uma nova sessão/agente. Deve informar:
- objetivo do projeto;
- stack e regras arquiteturais;
- o que já está pronto;
- o que falta;
- qual é a próxima tarefa exata;
- arquivos que devem ser lidos primeiro;
- comandos de build/teste/migration necessários;
- estimativa total de tokens ainda necessária;
- instrução explícita para continuar sem recriar funcionalidades já concluídas.

### Regra de retomada

Ao iniciar ou retomar a geração em um projeto que já possua `tasks/progress/PROJECT_STATUS.md`, o agente deve primeiro ler todos os arquivos de `tasks/progress/`, validar o estado existente e **continuar do último checkpoint**, em vez de reiniciar o projeto.

### Reserva de segurança

Sempre que houver indicação de limite disponível, reservar capacidade suficiente para gerar o checkpoint. O agente deve priorizar salvar `PROJECT_STATUS.md`, `PENDING_TASKS.md`, `TOKEN_ESTIMATE.md` e `CONTINUATION_PROMPT.md` antes de iniciar uma nova etapa que possa ultrapassar o limite.

Ao concluir 100% do projeto, manter esses arquivos como histórico, marcar `PENDING_TASKS.md` como sem pendências e registrar no `PROJECT_STATUS.md` que build, migrations, testes e execução final foram validados.


## Orçamento por ferramenta de IA

> Valores de referência. O consumo real depende do modelo selecionado, tamanho do contexto, quantidade de correções, testes, reexecuções e uso de cache. Atualize esta tabela quando os fornecedores alterarem preços.

### Premissa de geração

Para o CMS completo deste Harness, considerar inicialmente:

- cenário econômico: ~1,5 milhão de tokens processados;
- cenário provável: ~3,5 milhões de tokens processados;
- cenário alto: ~7 milhões de tokens processados;
- a distribuição entre entrada, cache e saída varia durante a execução;
- o agente deve registrar o consumo/estimativa em `tasks/progress/TOKEN_ESTIMATE.md`.

### Claude / Claude Code

Referência: Claude Sonnet 4.5 via API, com preço publicado de US$ 3,00 por 1 milhão de tokens de entrada e US$ 15,00 por 1 milhão de tokens de saída.

| Cenário | Tokens processados (aprox.) | Orçamento indicativo* |
|---|---:|---:|
| Econômico | 1,5 M | US$ 10–20 |
| Provável | 3,5 M | US$ 25–45 |
| Alto | 7,0 M | US$ 50–90 |

### OpenAI Codex

Referência de cálculo: GPT-5.3-Codex, US$ 1,75/M de entrada, US$ 0,175/M de entrada em cache e US$ 14/M de saída.

| Cenário | Tokens processados (aprox.) | Orçamento indicativo* |
|---|---:|---:|
| Econômico | 1,5 M | US$ 8–18 |
| Provável | 3,5 M | US$ 20–40 |
| Alto | 7,0 M | US$ 40–80 |

### GitHub Copilot

O Copilot possui cobrança própria e pode executar modelos/agentes diferentes. Portanto, não converter diretamente o total de tokens acima em preço sem considerar o modelo usado pelo Copilot.

Planos individuais de referência:

| Plano | Preço base mensal | Uso incluído |
|---|---:|---|
| Copilot Free | US$ 0 | Uso limitado |
| Copilot Pro | US$ 10/mês | inclui US$ 15 em AI Credits |
| Copilot Pro+ | US$ 39/mês | inclui US$ 70 em AI Credits |
| Copilot Max | US$ 100/mês | voltado a uso agentivo mais intenso |

O Harness deve registrar em `TOKEN_ESTIMATE.md` qual modelo foi efetivamente selecionado no Copilot e estimar eventual uso adicional conforme a tabela vigente de AI Credits do GitHub.

\* Os intervalos são orçamento de planejamento do projeto, não uma cotação garantida do fornecedor. Eles incluem margem para contexto repetido, geração, testes, correções e reexecuções.

### Regra para comparação

Ao iniciar a geração, registrar:

```text
Ferramenta:
Modelo:
Preço de entrada:
Preço de cache:
Preço de saída:
Tokens estimados:
Orçamento inicial:
Data da estimativa:
```

Ao criar um checkpoint, atualizar:

```text
Tokens estimados já utilizados:
Tokens estimados restantes:
Custo estimado já utilizado:
Custo adicional estimado:
Custo total projetado:
Percentual aproximado concluído:
```

Nunca inventar saldo real de tokens, créditos ou assinatura. Quando a ferramenta não fornecer o consumo real, marcar os números como `ESTIMATIVA`.

## Economia de tokens

Este Harness possui um protocolo obrigatório de otimização de contexto. Ele combina:

- RTK (opcional) para compactar saída do terminal;
- leitura seletiva por task;
- Context Manifest;
- testes direcionados durante desenvolvimento;
- logs resumidos;
- checkpoints de continuidade;
- estimativa de tokens restantes;
- quality gates completos antes da entrega.

O RTK é uma dependência de desenvolvimento opcional e externa. O CMS gerado não depende
dele em runtime.

Consulte `docs/TOKEN-OPTIMIZATION.md` e `tools/rtk/README.md`.


## Testes e QA

A entrega final inclui testes unitários, testes de integração da API, coleção completa para Insomnia, cenários positivos/negativos, regressão de autenticação/permissões/conteúdo e Docker Compose com MySQL + API + React. Consulte o gate obrigatório no `PROJECT.md`.
