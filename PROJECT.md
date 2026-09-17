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

## Dados iniciais
Gerar seed/mocks funcionais com:
- usuário administrador;
- roles e permissions básicas;
- página Home;
- página Sobre;
- página Contato;
- posts de exemplo;
- menu principal;
- configurações institucionais básicas.

Credenciais locais de exemplo devem ser documentadas no README e nunca usadas como segredo de produção.

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

Site inicial:
- Home institucional simples
- Página por slug
- Listagem/detalhe de posts
- Menu
- Contato visual básico

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
