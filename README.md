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
