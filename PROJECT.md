# PROJECT — CMS C# + React + MySQL

## Objetivo
Gerar um CMS simples e evolutivo. As telas e funcionalidades futuras serão implementadas conforme tasks e referências de layout forem adicionadas ao projeto.

## Decisões obrigatórias
- Uma única API backend: `Cms.Api`.
- Uma única aplicação React, separada em módulos `admin` e `site`.
- Não criar Plugins ou Themes.
- Não criar APIs separadas para Auth/Admin/Site.
- Backend em C#/.NET 10 com ASP.NET Core Minimal APIs.
- Arquitetura Vertical Slices + CQRS + Domain Events.
- Persistência com Entity Framework Core, Migrations e MySQL.
- Frontend com React + Vite + TypeScript.
- Autenticação JWT + Refresh Token.
- Autorização por Roles e Permissions.
- Docker Compose deve executar API, React e MySQL.
- Ambientes: DEV, HML e PROD.

## Estrutura gerada
```text
backend/
  Cms.Api/
    Features/
      Auth/
      Users/
      Pages/
      Posts/
      Categories/
      Menus/
      Media/
      Settings/
    Domain/
    Infrastructure/
      Persistence/
      Security/
    Common/
    Migrations/
    Program.cs
    appsettings.json
    appsettings.Development.json
    appsettings.Homologation.json
    appsettings.Production.json
  tests/
    UnitTests/
    IntegrationTests/

frontend/
  src/
    admin/
      components/
      layouts/
      pages/
      features/
      routes/
      services/
    site/
      components/
      layouts/
      pages/
      features/
      routes/
      services/
    shared/
      components/
      hooks/
      api/
      types/
      utils/
  .env.development
  .env.homologation
  .env.production

tasks/
  examples/
  generated/
  backlog/
  reports/

screenshots/
layouts/
requirements/

docker-compose.yml
.env.dev
.env.hml
.env.prod
README.md
```

## Rotas da API
Separar responsabilidades por prefixo na mesma API:

```text
/api/auth/*
/api/admin/*
/api/site/*
```

### Auth inicial
```text
POST /api/auth/login
POST /api/auth/refresh-token
POST /api/auth/logout
POST /api/auth/forgot-password
POST /api/auth/reset-password
GET  /api/auth/me
```

### Admin inicial
CRUD básico para:
- Users
- Roles
- Permissions
- Pages
- Posts
- Categories
- Menus
- Media
- Settings

### Site inicial
Endpoints públicos para:
- Home
- Pages por slug
- Posts
- Categories
- Menus
- Settings públicos
- Search

## Vertical Slices
Cada operação deve ficar isolada por feature/operação.

Exemplo:
```text
Features/Users/
  Create/
    Endpoint.cs
    Command.cs
    Handler.cs
    Validator.cs
    Response.cs
  Update/
  Delete/
  GetById/
  List/
```

Evitar controllers monolíticos e services genéricos gigantes.

## Banco de dados
- MySQL.
- EF Core como ORM principal.
- Toda alteração estrutural deve possuir Migration.
- Não usar scripts SQL manuais para substituir migrations, salvo necessidade explicitamente documentada.
- Seeds devem criar dados mínimos para execução local.

Entidades iniciais sugeridas:
```text
User
Role
Permission
UserRole
RolePermission
RefreshToken
Page
Post
Category
PostCategory
Menu
MenuItem
Media
Setting
```

## Dados iniciais obrigatórios
A primeira execução deve entregar um CMS já utilizável, e não apenas a estrutura vazia. Gerar migrations e seeds funcionais com:
- usuários Admin, Editor, Leitor e Visitante;
- roles `Admin`, `Editor`, `Leitor` e `Visitante`;
- permissions por função;
- página Home completa;
- página Sobre;
- página Serviços;
- página Notícias;
- página Contato;
- pelo menos 3 posts/notícias de demonstração;
- categorias de demonstração;
- menu principal e menu de rodapé;
- configurações institucionais;
- dados de contato e redes sociais fictícios;
- conteúdo suficiente para o site não possuir seções vazias.

### Usuários DEV obrigatórios
Criar via seed os seguintes usuários locais. As senhas devem ser armazenadas somente como hash no MySQL; os valores abaixo são credenciais de demonstração DEV e devem permanecer documentados no README gerado.

| Perfil | E-mail | Senha DEV | Acesso |
|---|---|---|---|
| Admin | admin@cms.local | `CmsAdmin@2026!` | Acesso total ao CMS |
| Editor | editor@cms.local | `CmsEditor@2026!` | Gerenciar conteúdo, mídia, menus e categorias |
| Leitor | leitor@cms.local | `CmsLeitor@2026!` | Acesso autenticado somente leitura |
| Visitante | visitante@cms.local | `CmsVisitante@2026!` | Perfil autenticado básico, sem acesso administrativo |

### Permissions iniciais
Gerar no mínimo as permissions:
```text
users.view
users.create
users.update
users.delete
roles.manage
permissions.manage
pages.view
pages.create
pages.update
pages.delete
posts.view
posts.create
posts.update
posts.delete
categories.manage
menus.manage
media.view
media.upload
media.delete
settings.view
settings.update
```

O Admin recebe todas. O Editor recebe permissões de conteúdo, categorias, menus e mídia, sem gerenciamento de usuários/roles/permissions. O Leitor recebe apenas permissões `.view`. O Visitante não recebe permissões administrativas.

Estas credenciais são exclusivas para DEV/demonstração. HML/PROD não devem usar senhas fixas nem criar automaticamente essas contas com essas senhas.

## React
Uma única aplicação React.

Separação lógica:
```text
/admin/* -> módulo admin
/*       -> módulo site
```

Admin inicial:
- Login
- Recuperar senha
- Dashboard simples
- Usuários
- Conteúdo
- Configurações

Site inicial obrigatório e completo:
- Header com logo/nome do site e menu dinâmico
- Home institucional responsiva com Hero, Sobre, Serviços, Destaques/benefícios, Últimas Notícias e CTA
- Página Sobre
- Página Serviços
- Notícias com listagem e detalhe
- Página Contato com formulário visual e dados institucionais
- Footer com menu, contato, redes sociais e copyright
- Menu e conteúdo carregados da API/MySQL, não hardcoded no React
- Nenhuma seção principal vazia na primeira execução

Componentes reutilizáveis devem ficar em `shared` quando realmente forem compartilhados.

## Evolução por telas/tasks
Não tentar prever todas as telas no projeto inicial.

Novas telas serão fornecidas posteriormente por task, screenshot ou layout.

Exemplo:
```text
tasks/generated/TASK-001-admin-dashboard.md
screenshots/admin-dashboard.png
```

Ao executar uma task, o agente deve:
1. analisar requisito e referência visual;
2. identificar alterações no React;
3. identificar endpoints necessários;
4. identificar entidades/alterações no banco;
5. criar migration quando necessário;
6. implementar testes;
7. atualizar documentação;
8. registrar resultado em `tasks/reports/`.

## Configuração por ambiente
Backend:
```text
appsettings.Development.json
appsettings.Homologation.json
appsettings.Production.json
```

Frontend:
```text
.env.development
.env.homologation
.env.production
```

Docker:
```text
.env.dev
.env.hml
.env.prod
```

Segredos reais não devem ser versionados.

## Docker Compose
O Docker Compose final deve possuir no mínimo:
```text
mysql
api
frontend
```

Deve permitir subir o ambiente DEV com um único comando documentado no README.

## Qualidade
- Nullable habilitado.
- Async/await e CancellationToken em I/O.
- Validation antes dos handlers.
- ProblemDetails para erros HTTP.
- Global Exception Handler.
- Paginação padronizada.
- Logs estruturados.
- Health Check da API e banco.
- Unit Tests.
- Integration Tests.
- Build backend e frontend sem erros.

## Restrições
- Não gerar Plugins.
- Não gerar Themes.
- Não gerar WordPress/PHP.
- Não separar backend em Api.Auth, Api.Admin e Api.Site.
- Não criar microsserviços para o escopo inicial.
- Não adicionar bibliotecas sem necessidade comprovada.
- Preferir recursos nativos do .NET/React quando forem suficientes.

## Resultado esperado
Ao final da geração, o projeto deve estar executável localmente, com MySQL, API e React integrados, autenticação funcional, área administrativa inicial, site institucional inicial, migrations e dados seed.

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

## TOKEN OPTIMIZATION PROTOCOL — OBRIGATÓRIO

O projeto deve minimizar consumo de tokens sem comprometer qualidade, testes ou rastreabilidade.

### 1. RTK — Rust Token Killer

Antes de iniciar tarefas extensas, verificar se o RTK correto está disponível:

```bash
rtk --version
rtk gain
```

Se não estiver instalado, NÃO instalar silenciosamente. Registrar a recomendação em
`tasks/progress/PROJECT_STATUS.md` e continuar usando os mecanismos internos de compactação
deste Harness. A instalação é opcional e depende do ambiente do desenvolvedor.

Integrações recomendadas:

```bash
# Claude Code
rtk init -g

# OpenAI Codex
rtk init -g --codex

# GitHub Copilot
rtk init -g --copilot
```

Após configurar, reiniciar a ferramenta/agente quando necessário.

Usar RTK prioritariamente para comandos com saída volumosa, como git, testes, builds,
grep/find, Docker e gerenciadores de pacotes.

Nunca depender exclusivamente do RTK: o projeto deve continuar executável sem ele.

### 2. Context Budget

O agente NÃO deve reler o repositório inteiro a cada tarefa.

Antes de implementar uma task:

1. ler `PROJECT.md`;
2. ler `tasks/progress/PROJECT_STATUS.md`;
3. ler `tasks/context/PROJECT_MAP.md`;
4. ler o manifesto da task atual;
5. abrir somente arquivos relacionados;
6. expandir o contexto apenas quando uma dependência real exigir.

Evitar carregar simultaneamente módulos não relacionados.

### 3. Context Manifest por task

Cada task relevante deve informar seu contexto mínimo:

```yaml
task: ADMIN-USERS-EDIT
backend:
  - backend/src/Cms.Api/Features/Users
  - backend/src/Cms.Api/Domain/Users
frontend:
  - frontend/src/admin/features/users
  - frontend/src/shared/api
database:
  - Users
  - Roles
  - Permissions
tests:
  - backend/tests/**/Users
exclude:
  - Posts
  - Pages
  - Media
  - frontend/src/site
```

### 4. Saída silenciosa

Evitar:

- imprimir arquivos inteiros sem necessidade;
- `git diff` completo quando um diff filtrado basta;
- logs completos de testes aprovados;
- logs completos do Docker;
- listar `node_modules`, `bin`, `obj`, `dist`, coverage ou artefatos;
- repetir PROJECT.md/README.md nas respostas;
- repetir erros idênticos várias vezes.

Preferir resumos como:

```text
Build: OK
Tests: 487 passed / 2 failed
Failures:
- Users/CreateUserTests
- Users/UpdateUserTests
```

Abrir detalhes somente para investigar falhas.

### 5. Testes progressivos

Durante uma feature:

```text
teste da feature -> corrigir -> retestar feature -> build do módulo
```

Executar a suíte completa nos quality gates, antes de finalizar uma fase e antes da entrega.

### 6. Checkpoint e continuação

Atualizar continuamente:

```text
tasks/progress/
├── PROJECT_STATUS.md
├── COMPLETED_TASKS.md
├── PENDING_TASKS.md
├── CONTINUATION_PROMPT.md
└── TOKEN_ESTIMATE.md
```

Quando o contexto/tokens estiver próximo do limite:

1. não iniciar uma feature grande;
2. concluir ou estabilizar a menor unidade em andamento;
3. executar testes direcionados possíveis;
4. registrar arquivos alterados;
5. registrar problemas conhecidos;
6. registrar próxima ação exata;
7. estimar tokens adicionais necessários;
8. atualizar `CONTINUATION_PROMPT.md`;
9. permitir que outro agente/sessão continue sem reler todo o projeto.

Nunca inventar saldo real de tokens. Se o provedor não expuser esse dado, usar `ESTIMATIVA`.

### 7. Contexto resumido do projeto

Manter:

```text
tasks/context/
├── PROJECT_MAP.md
├── BACKEND_CONTEXT.md
├── FRONTEND_CONTEXT.md
├── DATABASE_CONTEXT.md
└── CURRENT_TASK_CONTEXT.md
```

Esses arquivos devem ser curtos e atualizados somente quando decisões relevantes mudarem.

### 8. Quality Gate

Economia de tokens nunca autoriza:

- pular compilação;
- remover testes;
- ignorar migrations;
- esconder erro;
- deixar código quebrado;
- substituir implementação por TODO;
- afirmar sucesso sem validação.


## QUALITY ASSURANCE E API TESTS — OBRIGATÓRIO

Ao final da geração, o projeto só pode ser considerado concluído após gerar e validar:

- testes unitários para domínio, handlers, validators, services, autenticação e autorização;
- testes de integração para todos os endpoints ASP.NET Core usando banco MySQL de teste isolado;
- cenários de sucesso e erro: 400, 401, 403, 404, 409 e demais respostas adotadas;
- JWT, refresh token, roles e permissions para Admin, Editor, Leitor e Visitante;
- CRUD, paginação, filtros, ordenação, validações, duplicidade e recurso inexistente;
- coleção completa importável no Insomnia contendo todos os endpoints e cenários de QA;
- ambientes Insomnia DEV, HML e PROD.example sem secrets reais em produção;
- fluxos de regressão completos e relatório final `qa/reports/QA-REPORT.md`.

### Estrutura QA obrigatória

```text
qa/
├── insomnia/
│   ├── CMS-API-Insomnia.json
│   ├── environments/DEV.json
│   ├── environments/HML.json
│   ├── environments/PROD.example.json
│   └── README.md
├── test-cases/
│   ├── AUTH-TEST-CASES.md
│   ├── USERS-TEST-CASES.md
│   ├── PERMISSIONS-TEST-CASES.md
│   ├── CONTENT-TEST-CASES.md
│   └── API-REGRESSION.md
└── reports/QA-REPORT.md
```

A coleção Insomnia deve agrupar Health, Auth, Admin e Site e usar variáveis como `base_url`, credenciais DEV, `access_token` e `refresh_token`. Para cada endpoint, quando aplicável, criar happy path, payload inválido/vazio, obrigatório ausente, duplicidade, ID inválido/inexistente, token ausente/inválido/expirado, role/permissão insuficiente, paginação/filtro/ordenação e conflitos. Nunca executar testes destrutivos contra PROD.

### Docker Compose — OBRIGATÓRIO

O projeto deve possuir `docker-compose.yml` funcional contendo no mínimo `mysql`, `api` e `frontend`, com healthchecks e ordem de inicialização adequada. `docker compose up -d --build` deve deixar MySQL, migrations/seeds DEV, API e React funcionais. Se testes exigirem infraestrutura separada, gerar compose de teste apropriado.

### Gate final

```text
[ ] Backend compila
[ ] Frontend compila
[ ] Migrations válidas
[ ] Docker Compose sobe MySQL + API + React
[ ] Seeds DEV funcionam
[ ] Unit tests executados
[ ] Integration tests executados
[ ] Todos endpoints estão no Insomnia
[ ] Cenários positivos e negativos estão cobertos
[ ] Roles/Permissions foram testadas
[ ] Regressão QA documentada
[ ] QA-REPORT.md gerado
```

Se qualquer gate falhar, registrar no checkpoint e não declarar `PROJECT COMPLETE`.
