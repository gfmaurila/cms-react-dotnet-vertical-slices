# CMS React + .NET Vertical Slices — Gerador

## Objetivo

Este pacote contém a especificação para um agente de IA gerar uma solução completa de CMS institucional, semelhante a um WordPress simplificado.

> **Importante:** antes da execução, este ZIP contém somente `PROJECT.md` e `README.md`. As pastas `backend`, `frontend`, os projetos .NET, React, Dockerfiles, migrations, testes e demais arquivos devem ser criados pelo agente somente ao executar o `PROJECT.md`.

## Arquitetura solicitada

```text
React
├── Site Público
└── Admin
     │
     ├───────────────┐
     │               │
 Api.Site        Api.Admin
                     │
                  JWT/RBAC
                     │
                  Api.Auth
                     │
              Application
                     │
                  Domain
                     │
              Infrastructure
                     │
                SQL Server
```

## Projetos que serão gerados

| Camada | Projeto/Aplicação | Responsabilidade |
|---|---|---|
| Backend | Api.Auth | Login, JWT, Refresh Token, logout e recuperação de senha |
| Backend | Api.Admin | CRUDs administrativos, CMS, usuários, roles e permissions |
| Backend | Api.Site | Conteúdo público do site institucional |
| Backend | Application | Vertical Slices, CQRS, handlers e validações |
| Backend | Domain | Entidades, regras, aggregates e Domain Events |
| Backend | Infrastructure | EF Core, SQL Server, autenticação, storage e serviços |
| Testes | UnitTests | Testes unitários |
| Testes | IntegrationTests | Testes de integração |
| Frontend | React Site | Site institucional público |
| Frontend | React Admin | Painel administrativo |

## Ambientes

### React

Serão gerados:

```text
frontend/.env.development
frontend/.env.homologation
frontend/.env.production
frontend/.env.example
```

### APIs .NET

Cada uma das APIs `Api.Auth`, `Api.Admin` e `Api.Site` terá:

```text
appsettings.json
appsettings.Development.json
appsettings.Homologation.json
appsettings.Production.json
```

### Docker / infraestrutura

Serão gerados:

```text
.env.dev
.env.hml
.env.prod
.env.example
docker-compose.yml
```

O mesmo `docker-compose.yml` será parametrizado pelo arquivo de ambiente selecionado.

## Docker Compose

Serviços:

```text
sqlserver
api-auth
api-admin
api-site
frontend
```

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

## Dados iniciais

Durante a geração serão criados seeds para DEV/HML com:

- usuário Administrator;
- usuário Editor;
- usuário Author;
- usuário Viewer;
- roles e permissions;
- páginas institucionais;
- menus;
- categorias;
- posts;
- configurações do site.

O site institucional inicial terá Home, Sobre Nós, Serviços, Blog, Contato e Política de Privacidade, além de conteúdo de demonstração.

Credenciais de demonstração serão documentadas pelo agente no README final e deverão ser usadas somente em DEV/HML. Produção não deverá depender de senha padrão insegura.

## Autenticação e autorização

A solução deverá implementar:

```text
JWT Access Token
Refresh Token com rotação
Logout / revogação
Forgot Password
Reset Password
Roles
Permissions
Protected Routes
Permission Guards
```

A autorização efetiva sempre será validada pelo backend.

## Docker

Cada API e o frontend terão Dockerfile. O `docker-compose.yml` deverá subir banco SQL Server, três APIs e frontend, com health checks, networking e volume persistente.

## Estimativa de geração por IA

Os números abaixo são **estimativas de planejamento**, não medição antecipada do consumo real. O total varia conforme o modelo/agente, quantidade de correções, tamanho dos testes, logs de ferramentas e quantas vezes arquivos são relidos ou reescritos.

Para a conversão ilustrativa abaixo foi adotado **US$ 1 = R$ 5,50**. O custo real depende do preço do modelo utilizado; por isso a tabela apresenta uma faixa de custo de geração, e não uma cobrança garantida.

| Etapa | Tokens estimados* | Custo estimado US$** | Custo estimado R$** | Tempo estimado |
|---|---:|---:|---:|---:|
| Planejamento + arquitetura | 25k–50k | US$ 0,50–2,00 | R$ 2,75–11,00 | 10–25 min |
| Backend + Domain + Infrastructure | 100k–220k | US$ 2,00–9,00 | R$ 11,00–49,50 | 35–90 min |
| Api.Auth + segurança | 45k–90k | US$ 0,90–4,00 | R$ 4,95–22,00 | 20–45 min |
| Api.Admin + CMS | 80k–170k | US$ 1,60–7,00 | R$ 8,80–38,50 | 30–75 min |
| Api.Site + conteúdo inicial | 35k–75k | US$ 0,70–3,00 | R$ 3,85–16,50 | 15–35 min |
| React Site + Admin | 100k–220k | US$ 2,00–9,00 | R$ 11,00–49,50 | 35–90 min |
| Testes + correções | 80k–200k | US$ 1,60–8,00 | R$ 8,80–44,00 | 30–120 min |
| Docker + ambientes + documentação | 40k–90k | US$ 0,80–4,00 | R$ 4,40–22,00 | 20–45 min |
| **Total aproximado** | **505k–1,115M** | **US$ 10,10–46,00** | **R$ 55,55–253,00** | **3h15–8h45** |

\* Tokens representam uma estimativa ampla do tráfego de contexto/geração ao longo de uma execução agentic completa; não equivalem necessariamente apenas ao código final.

\** O valor em dinheiro não pode ser calculado exatamente sem definir o modelo e sua tabela de preços de entrada, saída e cache. A faixa acima é apenas orçamento de referência e deve ser substituída por cálculo baseado no modelo efetivamente usado.

O tempo também depende da máquina, download de pacotes/imagens Docker, velocidade do agente e quantidade de ciclos de build/test/correção.

## Como executar a geração

Entregue o diretório ao agente e solicite:

```text
Leia completamente o PROJECT.md e implemente TODO o projeto descrito.

Não crie somente scaffolding.
Gere a solução funcional completa.

Crie backend, frontend, banco, migrations, seeds, testes,
configurações DEV/HML/PROD e docker-compose.yml.

Execute builds e testes, valide o Docker Compose,
corrija os erros encontrados e atualize o README.md
com a configuração final realmente gerada.
```

O `PROJECT.md` é a fonte principal de requisitos.
