# PROJECT — GERADOR CMS React + .NET Vertical Slices

## REGRA PRINCIPAL

Este pacote é uma ESPECIFICAÇÃO DE GERAÇÃO. Antes da execução deve conter somente `PROJECT.md` e `README.md`.

NÃO criar previamente as pastas `backend`, `frontend`, `docker` ou qualquer código-fonte no template.

Ao receber a ordem para executar este `PROJECT.md`, o agente deve gerar do zero toda a solução descrita abaixo no diretório atual.

A execução somente será considerada concluída quando a solução estiver criada, compilando, testada e com o Docker Compose validado.

---

# 1. OBJETIVO

Gerar um CMS estilo WordPress simplificado com:

- Site institucional público em React + TypeScript.
- Área administrativa em React + TypeScript.
- Backend C# / .NET 10.
- Api.Auth.
- Api.Admin.
- Api.Site.
- Vertical Slice Architecture.
- Domain / DDD.
- CQRS.
- Domain Events.
- SQL Server.
- JWT Access Token.
- Refresh Token.
- Forgot Password / Reset Password.
- Roles e Permissions.
- Permissões por tela e endpoint.
- Dados iniciais/mocks/seeds.
- Conteúdo inicial para site institucional.
- Docker Compose único com todos os serviços.
- Configurações DEV, HML e PROD.

---

# 2. ESTRUTURA QUE DEVE SER GERADA

Somente DURANTE a execução criar:

```text
project/
├── backend/
│   ├── src/
│   │   ├── Api.Auth/
│   │   ├── Api.Admin/
│   │   ├── Api.Site/
│   │   ├── Application/
│   │   ├── Domain/
│   │   └── Infrastructure/
│   └── tests/
│       ├── UnitTests/
│       └── IntegrationTests/
│
├── frontend/
│   ├── src/
│   │   ├── site/
│   │   ├── admin/
│   │   ├── auth/
│   │   └── shared/
│   ├── .env.development
│   ├── .env.homologation
│   ├── .env.production
│   └── .env.example
│
├── scripts/
│   └── sqlserver/
│
├── docker-compose.yml
├── .env.dev
├── .env.hml
├── .env.prod
├── .env.example
├── PROJECT.md
└── README.md
```

Não criar uma pasta `docker/`. O projeto deve utilizar um `docker-compose.yml` único parametrizado por ambiente.

---

# 3. BACKEND

Stack:

- .NET 10
- ASP.NET Core
- Minimal APIs
- Vertical Slices
- Domain Driven Design
- CQRS
- Domain Events
- Entity Framework Core
- SQL Server
- FluentValidation
- JWT Bearer
- Refresh Token
- Serilog
- Swagger / OpenAPI
- xUnit
- Moq

Projetos obrigatórios:

```text
Api.Auth
Api.Admin
Api.Site
Application
Domain
Infrastructure
UnitTests
IntegrationTests
```

As APIs compartilham Application, Domain e Infrastructure, respeitando separação de responsabilidades.

---

# 4. API.AUTH

Responsável por autenticação e sessão.

Endpoints:

```text
POST /api/auth/login
POST /api/auth/refresh-token
POST /api/auth/logout
POST /api/auth/forgot-password
POST /api/auth/reset-password
GET  /api/auth/me
GET  /health
```

Implementar:

- login
- hash de senha
- JWT Access Token
- Refresh Token
- Refresh Token armazenado como hash
- rotação de Refresh Token
- revogação
- logout
- forgot password
- reset password
- rate limiting
- identificação do usuário autenticado

Api.Admin e Api.Site devem validar JWT localmente quando necessário, sem chamar Api.Auth em toda requisição.

---

# 5. API.ADMIN

Endpoints administrativos:

```text
/api/admin/dashboard
/api/admin/users
/api/admin/roles
/api/admin/permissions
/api/admin/pages
/api/admin/posts
/api/admin/categories
/api/admin/menus
/api/admin/media
/api/admin/settings
/health
```

CRUDs administrativos devem possuir paginação, pesquisa, validação e autorização.

Exemplos:

```text
GET    /api/admin/users       -> Users.View
POST   /api/admin/users       -> Users.Create
PUT    /api/admin/users/{id}  -> Users.Edit
DELETE /api/admin/users/{id}  -> Users.Delete
```

---

# 6. API.SITE

API de leitura para o site institucional:

```text
GET /api/site/home
GET /api/site/pages/{slug}
GET /api/site/posts
GET /api/site/posts/{slug}
GET /api/site/categories
GET /api/site/categories/{slug}/posts
GET /api/site/menus/{name}
GET /api/site/settings
GET /api/site/search
GET /health
```

Não implementar CRUD administrativo na Api.Site.

---

# 7. DOMAIN + VERTICAL SLICES

Domain não pode depender de ASP.NET, Entity Framework, SQL Server ou Infrastructure.

Domínios:

```text
Users
Roles
Permissions
Authentication
Pages
Posts
Categories
Menus
Media
Settings
```

Features:

```text
Application/Features/
├── Auth/
│   ├── Login/
│   ├── RefreshToken/
│   ├── Logout/
│   ├── ForgotPassword/
│   └── ResetPassword/
├── Users/
├── Roles/
├── Permissions/
├── Pages/
├── Posts/
├── Categories/
├── Menus/
├── Media/
└── Settings/
```

Cada operação deve possuir os componentes necessários, como Command/Query, Handler, Validator, Response e Endpoint.

---

# 8. PERMISSIONS

Modelo:

```text
User -> Role -> Permission
```

Permissões mínimas:

```text
Dashboard.View

Users.View
Users.Create
Users.Edit
Users.Delete

Roles.View
Roles.Create
Roles.Edit
Roles.Delete

Permissions.View
Permissions.Edit

Pages.View
Pages.Create
Pages.Edit
Pages.Delete
Pages.Publish

Posts.View
Posts.Create
Posts.Edit
Posts.Delete
Posts.Publish

Categories.View
Categories.Create
Categories.Edit
Categories.Delete

Menus.View
Menus.Create
Menus.Edit
Menus.Delete

Media.View
Media.Upload
Media.Delete

Settings.View
Settings.Edit
```

A autorização obrigatoriamente deve ser validada no Backend.

React deve possuir ProtectedRoute e PermissionGuard.

---

# 9. REACT

Stack:

- React
- TypeScript
- Vite
- React Router
- Axios
- TanStack Query
- React Hook Form
- Zod

Gerar:

```text
frontend/src/
├── site/
├── admin/
├── auth/
└── shared/
```

Admin:

```text
Dashboard
Users
Roles
Permissions
Pages
Posts
Categories
Menus
Media
Settings
```

CRUDs devem possuir:

```text
list
create
edit
details
```

Admin deve possuir Sidebar, Header, Breadcrumb, User Menu e menu dinâmico por permissions.

---

# 10. CONFIGURAÇÃO REACT POR AMBIENTE

Gerar obrigatoriamente:

```text
frontend/.env.development
frontend/.env.homologation
frontend/.env.production
frontend/.env.example
```

Variáveis:

```text
VITE_APP_ENV=
VITE_AUTH_API_URL=
VITE_ADMIN_API_URL=
VITE_SITE_API_URL=
```

Valores devem apontar para as URLs correspondentes de DEV, HML e PROD.

Nunca colocar JWT secret, senha SQL ou qualquer secret do backend nos arquivos React.

---

# 11. APPSETTINGS DAS APIs

Cada uma das três APIs deve possuir:

```text
appsettings.json
appsettings.Development.json
appsettings.Homologation.json
appsettings.Production.json
```

Portanto:

```text
Api.Auth/
├── appsettings.json
├── appsettings.Development.json
├── appsettings.Homologation.json
└── appsettings.Production.json

Api.Admin/
├── appsettings.json
├── appsettings.Development.json
├── appsettings.Homologation.json
└── appsettings.Production.json

Api.Site/
├── appsettings.json
├── appsettings.Development.json
├── appsettings.Homologation.json
└── appsettings.Production.json
```

Configurações sensíveis devem aceitar override por variáveis de ambiente.

---

# 12. ENV DO DOCKER/RAIZ

Gerar:

```text
.env.dev
.env.hml
.env.prod
.env.example
```

Variáveis mínimas:

```text
APP_ENV=
ASPNETCORE_ENVIRONMENT=

AUTH_API_PORT=
ADMIN_API_PORT=
SITE_API_PORT=
FRONTEND_PORT=

SQLSERVER_HOST=
SQLSERVER_PORT=
SQLSERVER_DATABASE=
SQLSERVER_USER=
SQLSERVER_PASSWORD=

JWT_ISSUER=
JWT_AUDIENCE=
JWT_SECRET=
JWT_ACCESS_TOKEN_MINUTES=
JWT_REFRESH_TOKEN_DAYS=

CORS_ALLOWED_ORIGINS=
LOG_LEVEL=
```

Mapeamento:

```text
DEV  -> Development
HML  -> Homologation
PROD -> Production
```

---

# 13. MOCK / SEED OBRIGATÓRIO

No ato da geração, criar dados iniciais para que o sistema funcione imediatamente após migrations/seed.

Nunca depender apenas de objetos mockados no React para autenticação. Os usuários iniciais devem existir no backend/banco por seed.

Criar usuários de desenvolvimento/homologação documentados no README.

Exemplo conceitual:

```text
Administrador
Editor
Autor
Visualizador
```

Criar Roles:

```text
Administrator
Editor
Author
Viewer
```

Administrator deve receber todas as permissions.

Editor deve administrar conteúdo, mas não usuários/roles críticos.

Author deve criar/editar conteúdo conforme regras definidas.

Viewer deve possuir somente permissões de leitura autorizadas.

Senhas de exemplo DEV/HML devem ser claramente marcadas como dados não produtivos e configuráveis.

PROD não deve criar senha padrão insegura automaticamente; bootstrap administrativo deve ser configurável por variável segura ou rotina documentada.

---

# 14. CONTEÚDO INICIAL DO SITE INSTITUCIONAL

O seed deve gerar conteúdo suficiente para visualizar o site imediatamente.

Configurações:

```text
Nome: Empresa Exemplo
Descrição: Soluções digitais para empresas
E-mail: contato@empresa-exemplo.local
Telefone: (00) 0000-0000
```

Páginas:

```text
Home
Sobre Nós
Serviços
Contato
Política de Privacidade
```

Home deve possuir conteúdo inicial com:

```text
Hero
Título
Subtítulo
Call To Action
Sobre
Serviços
Diferenciais
Contato
```

Criar serviços de exemplo:

```text
Consultoria
Desenvolvimento de Software
Integrações
Suporte
```

Criar posts de exemplo e categorias para demonstrar o módulo de conteúdo.

Criar menus:

```text
Principal
Rodapé
```

Menu Principal:

```text
Home
Sobre Nós
Serviços
Blog
Contato
```

O site React deve consumir esses dados pela Api.Site, não por JSON estático como fonte principal.

---

# 15. SQL SERVER

Criar migrations e seed.

Tabelas mínimas:

```text
Users
Roles
UserRoles
Permissions
RolePermissions
RefreshTokens
PasswordResetTokens
Pages
Posts
Categories
PostCategories
Menus
MenuItems
Media
Settings
```

---

# 16. DOCKER COMPOSE ÚNICO

Gerar somente:

```text
docker-compose.yml
```

Ele deve criar/subir:

```text
sqlserver
api-auth
api-admin
api-site
frontend
```

O mesmo compose deve funcionar com arquivos `.env` diferentes.

DEV:

```bash
docker compose --env-file .env.dev up -d --build
```

HML:

```bash
docker compose --env-file .env.hml up -d --build
```

PROD:

```bash
docker compose --env-file .env.prod up -d --build
```

O Docker Compose deve:

1. Subir SQL Server.
2. Aguardar health check do banco.
3. Subir Api.Auth.
4. Subir Api.Admin.
5. Subir Api.Site.
6. Executar/aplicar migrations de maneira controlada.
7. Garantir seed apropriado ao ambiente.
8. Subir frontend.
9. Configurar networking interno.
10. Persistir banco em volume.
11. Usar health checks.

Cada API deve possuir Dockerfile.

Frontend deve possuir Dockerfile.

---

# 17. HEALTH CHECK

Todas as APIs:

```text
GET /health
```

Docker Compose deve verificar saúde dos serviços.

---

# 18. TESTES

Gerar:

```text
UnitTests
IntegrationTests
```

Cobrir:

- Domain
- Commands
- Queries
- Validators
- Login
- JWT
- Refresh Token
- Forgot Password
- Reset Password
- Permissions
- CRUDs principais
- Api.Site
- Seeds essenciais

Autorização:

```text
Sem JWT            -> 401
JWT sem permission -> 403
JWT com permission -> sucesso
```

---

# 19. README GERADO/ATUALIZADO

Durante a implementação, atualizar o `README.md` com a configuração REAL gerada.

Ele deve conter:

- objetivo
- arquitetura
- árvore dos projetos
- stack
- configuração das três APIs
- configuração React
- DEV/HML/PROD
- variáveis de ambiente
- usuários/roles de exemplo de DEV/HML
- execução local
- migrations
- testes
- Docker Compose
- endpoints
- permissions
- segurança
- troubleshooting
- estimativa de geração

Manter no README a tabela de estimativa já existente, ajustando-a se a implementação final mudar substancialmente de tamanho.

---

# 20. FLUXO DE EXECUÇÃO

Antes de escrever código:

1. Ler completamente PROJECT.md.
2. Criar plano de arquitetura.
3. Criar plano de execução.
4. Dividir em tasks.
5. Gerar solution e projetos .NET.
6. Gerar React.
7. Implementar Domain.
8. Implementar Infrastructure.
9. Implementar Api.Auth.
10. Implementar Api.Admin.
11. Implementar Api.Site.
12. Implementar React Admin.
13. Implementar React Site.
14. Implementar migrations.
15. Implementar seed/mock inicial.
16. Criar configurações DEV/HML/PROD.
17. Criar Dockerfiles.
18. Criar docker-compose.yml.
19. Executar backend build.
20. Executar frontend build.
21. Executar testes.
22. Validar Docker Compose.
23. Corrigir erros.
24. Atualizar README.

Não encerrar deixando TODOs essenciais, endpoints fictícios ou funcionalidades principais somente simuladas.

---

# 21. DEFINITION OF DONE

Somente considerar concluído quando:

```text
Backend criado
Api.Auth criada
Api.Admin criada
Api.Site criada
Frontend criado
Site criado
Admin criado
JWT funcionando
Refresh Token funcionando
Forgot/Reset Password implementado
Permissions implementadas
SQL Server configurado
Migrations criadas
Seed criado
Conteúdo institucional criado
React DEV/HML/PROD configurado
APIs Development/Homologation/Production configuradas
docker-compose.yml criado
Docker Compose sobe banco + 3 APIs + frontend
Backend build OK
Frontend build OK
Testes OK
README atualizado
```
