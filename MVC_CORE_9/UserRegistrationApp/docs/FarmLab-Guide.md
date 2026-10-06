# FarmLab — Learning Plan and Training App Guide

6 October 2026 · Md Abdullah Al Noman

FarmLab is a small training version of FarmAI, built on the same architecture, so every skill FarmAI needs is learnt and tested here first. Build it stage by stage in a separate Claude session, one small task at a time, each finished with a passing test.

## 1. Your current app

UserRegistrationApp is a fresh ASP.NET Core Razor Pages project on .NET 9, with user models but no database, form or sign-in yet. That makes it a good warm-up before FarmLab. The folder is called MVC_CORE_9, but the app uses Razor Pages, not MVC controllers; Razor syntax is also the base of Blazor, which FarmAI uses.

| What it has | What it already teaches |
| --- | --- |
| .NET 9 web project with nullable reference types and implicit usings | Project file basics and modern C# defaults |
| Razor Pages: Index, Privacy, Error, RegisterUser, with a Bootstrap layout | Page routing, layouts and page models |
| Template `Program.cs`: HTTPS redirect, routing, static assets | The request pipeline and middleware order |
| Models: User with Addresses, ContactMethods and SocialLinks | One-to-many entities that map directly to EF Core |

**What is missing** (each becomes an exercise in stages 2 to 4):

- The RegisterUser page has headings only: no form, model binding or validation.
- The code-behind file is named `RegisterUser.csthml.cs` (letters swapped), and the page has no `@model` line, so its page model is never used. Rename it to `RegisterUser.cshtml.cs` and add `@model RegisterUserModel`.
- The `Data` folder is empty: no EF Core, no `DbContext`, no database.
- `User.PasswordHash` is a plain string that nothing hashes; ASP.NET Core Identity will replace it.
- No tests and no Git repository.

**Decision:** finish this app as the warm-up (stages 1 to 4), then build FarmLab as a new solution beside it. The warm-up stays small, and FarmLab starts with FarmAI's real structure from its first commit.

## 2. What you need to learn

These are the skills FarmAI's stack needs, in the order you will learn them. The stage column points to section 5, where each skill is practised and tested.

| Area | What to learn | Why FarmAI needs it | Stage |
| --- | --- | --- | --- |
| Tools | Git branches and pull requests, GitHub, the terminal | Every task is a pull request | 0 |
| C# | Records, pattern matching, nullable types, LINQ, generics, async/await | All platform code is C# | 1 |
| Testing | xUnit, assertions, writing the test first | Every requirement has a test | 1 onward |
| ASP.NET Core | Request pipeline, middleware, routing, dependency injection, configuration, logging, Razor syntax, model binding, validation | The API and web hosts | 2 |
| Data | EF Core, `DbContext`, relationships, migrations, LINQ queries, PostgreSQL and SQL basics | All business data | 3 |
| Integration testing | Testcontainers: tests against a real PostgreSQL, later RabbitMQ | Tests run against real dependencies | 3 onward |
| Accounts | ASP.NET Core Identity, password hashing, cookies, roles, claims | User accounts and roles | 4 |
| Architecture | Modular monolith, module boundaries, architecture tests, Aspire for local runs | One codebase, five hosts | 5 |
| APIs | Minimal APIs, OpenAPI, problem details, API versioning | Mobile app and partner access | 6 |
| Separation between businesses | Tenant context, EF Core global query filters, isolation tests | Each business sees only its own data | 6 |
| Sign-in | OpenID Connect, OAuth 2.0, JWT, Duende IdentityServer, SMS one-time codes, two-factor sign-in | One sign-in for web and mobile, by phone number | 7 |
| IoT messaging | MQTT, RabbitMQ exchanges and queues, the MQTT plugin, device certificates | Devices send readings | 8 |
| Time series | TimescaleDB hypertables, compression, continuous aggregates | Storing readings | 8 |
| Reliable messaging | MassTransit, events and commands, transactional outbox, retries, idempotency, scheduled messages | Hosts talk to each other without losing anything | 9 |
| Background work | Hosted services, Quartz.NET | Timers and nightly jobs | 9 and 11 |
| Domain logic | Rules, the alert lifecycle as a state machine, hysteresis | Correct alerts, no flapping | 10 |
| Caching | Valkey (Redis-compatible), distributed locks | Fast rule evaluation | 10 |
| Integrations | Provider interfaces, HTTP clients, retries and circuit breakers | SMS, WhatsApp and push | 11 |
| Web UI | Blazor Server and WebAssembly, components, MudBlazor, charts through JavaScript interop, SignalR | Customer portal and back-office | 12 |
| Mobile | Dart, Flutter, Firebase Cloud Messaging, local notifications, Android full-screen alarm, a little Kotlin | The alarm app | 13 |
| AI | Python, pandas, scikit-learn, Jupyter, MLflow, ONNX export, ONNX Runtime in C# | Learned limits and anomaly detection | 14 |
| Data lake | Parquet, Apache Iceberg, PyIceberg, DuckDB, S3 storage on SeaweedFS | History and AI training | 15 |
| Observability | OpenTelemetry logs, metrics and traces; Prometheus, Grafana, Loki | Find problems fast | 16 |
| Containers and Kubernetes | Docker images, Kubernetes basics, k3d, Helm, operators (CloudNativePG, RabbitMQ), Traefik | The production platform | 17 |
| Delivery and security | GitHub Actions, container registry, Argo CD, SOPS, Trivy, software bill of materials, Renovate | Safe, repeatable releases | 18 |

Not needed for FarmLab: the device hardware, the data centre and RKE2 itself. k3d on your Mac teaches the same Kubernetes skills.

## 3. The training app: FarmLab

FarmLab is FarmAI in miniature: the same hosts, messaging and data stores, running on your Mac, with simulators in place of real devices and paid message providers.

Architecture (text version of the diagram in the online guide):

```text
Alert path:
  Device simulator --MQTT--> RabbitMQ --> Ingestion host --> Evaluation host --> Notification host
      --> Providers (fake SMS and WhatsApp, Mailpit, Firebase) --> Android phone (Flutter alarm app)

Web side:
  Web browser --> API and web host (Blazor, REST API, SignalR) --- Identity host (Duende, phone sign-in, roles)

AI and data:
  PostgreSQL + TimescaleDB --nightly copy--> Data lake (Iceberg tables on SeaweedFS, DuckDB queries)
      --> Jupyter and MLflow (train, track, export ONNX) --ONNX model--> Evaluation host

Other parts: Jobs host (test alerts, nightly jobs), Valkey (rule cache, SignalR backplane),
SeaweedFS (S3 storage for lake files and models).
Runs on your MacBook: Aspire now, a k3d cluster later.
Also learnt: OpenTelemetry, GitHub Actions, Helm, Argo CD, Prometheus, Grafana, Loki.
```

A simulated oxygen drop travels the same path a real one will in FarmAI: device, RabbitMQ, ingestion, evaluation, notification, then the alarm on your phone.

| FarmAI part | FarmLab stand-in |
| --- | --- |
| Monitoring devices | DeviceSimulator, a console app sending MQTT readings |
| SMS, voice and WhatsApp providers | Fake providers that write each message to the log |
| Email service | Mailpit, a local test inbox |
| Firebase and Apple push | Real Firebase Cloud Messaging (free), Android only |
| Tier III data centre and RKE2 servers | Your MacBook: Aspire first, then a k3d cluster |
| Three-server database cluster | One PostgreSQL container; CloudNativePG in k3d at stage 17 |
| Real farms and customers | Two demo businesses with seeded sites, units and devices |

**In scope:** accounts and roles, sites, units and devices, readings, rules and alerts, notifications and escalation, the web portal and back-office, the Android alarm app, one AI model and the data lake.

**Left out to keep it small:** zones, batches and unit profiles (good extra tasks later), billing, partners, reports, real WhatsApp, the iPhone alarm, weather data and other languages.

## 4. Solution layout and conventions

FarmLab uses FarmAI's planned layout, so the structure you learn is the one you will build for real. Create it at `/Users/noman/Projects/ReLearnDotNet/FarmLab` in stage 5.

```text
FarmLab/
├── FarmLab.slnx                    solution file
├── Directory.Build.props           shared settings: .NET 10, nullable, warnings as errors
├── Directory.Packages.props        every NuGet version in one place
├── .editorconfig
├── CLAUDE.md                       working rules for the Claude session (section 7)
├── docs/
│   ├── FarmLab-Guide.md            this guide
│   ├── learning-log.md             what you learnt at each stage
│   ├── requirements/               one Markdown file per module
│   └── decisions/                  short architecture decision records
├── src/
│   ├── AppHost/                    Aspire: starts everything locally
│   ├── ServiceDefaults/            logging, tracing and health checks for every host
│   ├── Hosts/
│   │   ├── FarmLab.Api             REST API, Blazor server, SignalR
│   │   ├── FarmLab.Identity        Duende IdentityServer
│   │   ├── FarmLab.Ingestion       readings in over MQTT
│   │   ├── FarmLab.Evaluation      rules and AI models
│   │   ├── FarmLab.Notification    alarms, escalation, providers
│   │   └── FarmLab.Jobs            scheduled and nightly jobs
│   ├── Modules/
│   │   ├── Accounts/               businesses, users, roles
│   │   ├── FarmStructure/          sites, units, devices
│   │   ├── Readings/
│   │   ├── Alerts/
│   │   └── Notifications/          each module: one project plus a small .Contracts project
│   ├── Shared/
│   │   ├── FarmLab.SharedKernel    base types, tenant context, clock
│   │   └── FarmLab.Messaging       MassTransit set-up
│   └── Web/
│       ├── FarmLab.Web.Client      Blazor WebAssembly customer portal
│       └── FarmLab.Web.Components  shared Razor components
├── tools/FarmLab.DeviceSimulator   console app that acts as monitoring devices
├── mobile/farmlab_alarm/           Flutter alarm app
├── ml/                             Python notebooks, training and data lake jobs
├── deploy/                         Helm charts and k3d cluster set-up
├── tests/
│   ├── FarmLab.UnitTests
│   ├── FarmLab.IntegrationTests    real PostgreSQL and RabbitMQ through Testcontainers
│   ├── FarmLab.ArchitectureTests   module boundaries
│   └── FarmLab.EndToEndTests       reading to alert to notification
└── .github/workflows/              build, test and scan on every pull request
```

**Conventions**

- **Settings:** .NET 10, nullable reference types, warnings treated as errors, central package management.
- **Modules:** inside a module, one folder per feature (for example `Alerts/Acknowledge`), not one folder per technical layer. A module never reads another module's tables; it uses that module's `.Contracts` project or a message. Architecture tests enforce this.
- **Database:** one PostgreSQL database with one schema per module (`accounts`, `farm`, `readings`, `alerts`, `notifications`).
- **Separation between businesses:** every business-owned table has a `BusinessId`, filtered automatically by EF Core global query filters and proven by tests.
- **Time:** store `DateTimeOffset` in UTC; show each site's local time on screen.
- **Tests:** each test names its requirement, for example `[Trait("Req", "ALR-FR-012")]`. A bug gets a failing test before its fix.
- **Git:** `main` always builds and passes; one branch and one pull request per task; small commits with clear messages.
- **Secrets:** .NET user-secrets on your Mac; never in Git.

## 5. Learning path

Nineteen stages in five parts. Finish each stage, with its test passing, before starting the next; a stage usually splits into several small tasks of one pull request each.

### Part A — Foundations, in UserRegistrationApp

| Stage | You build | Done when |
| --- | --- | --- |
| 0. Mac and Git | Install the tools in section 6; put the app under Git and push it to a private GitHub repository; fix the misnamed code-behind file in your first pull request | That pull request is merged |
| 1. Modern C# and tests | A small class library of registration rules (username rules, Bangladeshi phone numbers in +880 format) using records, pattern matching and LINQ, with an xUnit test project | At least ten tests pass with `dotnet test` |
| 2. ASP.NET Core basics | Move the app to .NET 10; build the RegisterUser form with model binding and validation; a registration service through dependency injection, held in memory; the options pattern and logging | Invalid input shows clear errors; a valid form shows a confirmation; the service has unit tests |
| 3. EF Core and PostgreSQL | PostgreSQL in Docker; the Npgsql EF Core provider; an `AppDbContext` for User, Address, ContactMethod and SocialLink; migrations; a page that lists and edits users | Data survives a restart; an integration test with Testcontainers saves and reads a user |
| 4. Accounts | Replace `PasswordHash` with ASP.NET Core Identity: register, sign in, sign out, roles (Admin, User), an admin-only page | A test proves a normal user cannot open the admin page |

### Part B — FarmLab core

| Stage | You build | Done when |
| --- | --- | --- |
| 5. Solution skeleton | The layout in section 4; shared build settings; central packages; an Aspire AppHost starting PostgreSQL with TimescaleDB, RabbitMQ and Valkey; ServiceDefaults; architecture tests; a GitHub Actions build | All hosts show healthy in the Aspire dashboard; CI passes; an architecture test fails when one module uses another's internals |
| 6. Farm structure and businesses | Business, Site, Unit and Device in the Accounts and FarmStructure modules; Minimal APIs with OpenAPI; a tenant context with global query filters; two demo businesses | An isolation test: a user of business A gets "not found" for business B's unit |
| 7. Sign-in | The Identity host: Duende IdentityServer on ASP.NET Core Identity; phone-number sign-in with a code from a fake SMS sender that writes to the log; roles Owner, Site manager, Operator, Viewer and Admin; JWT-protected API; authenticator-app sign-in for admins | Tests: no token gives 401; an operator changing a limit gives 403 |
| 8. Readings in | RabbitMQ with its MQTT plugin; the DeviceSimulator sending oxygen, pH, temperature and power state for many units; the Ingestion host validating, dropping duplicates and storing readings in a TimescaleDB hypertable with measurement time, receipt time, sensor status and data-source label. Extra task: device certificates instead of passwords | 100 simulated units for 10 minutes store 1,000 readings; a repeated message is rejected; an integration test covers both |
| 9. Messaging between hosts | MassTransit over RabbitMQ; a `ReadingReceived` event; the EF Core outbox; retries, an error queue and idempotent consumers | Stop the Evaluation host, send readings, restart it: every reading is processed exactly once |
| 10. Rules and alerts | The Evaluation host: limit rules by species and stage, rate-of-change rules, the alert lifecycle (open, acknowledged, resolved) with hysteresis and a minimum duration, rules cached in Valkey, an alert when a unit stops reporting | Unit tests for every rule; end to end, a falling oxygen level raises one alert, not one per reading |
| 11. Notifications and escalation | The Notification host; one provider interface with a fake SMS sender, a fake WhatsApp sender and email through Mailpit; on-call order; escalation with scheduled messages (Quartz.NET); delivery and acknowledgement tracking; an automatic test alert every few minutes | With a fake clock, an unacknowledged critical alert moves to the next person after the set time |

### Part C — Screens

| Stage | You build | Done when |
| --- | --- | --- |
| 12. Blazor web | Customer portal (WebAssembly) and back-office (Server) with MudBlazor; site and unit pages; a live readings chart using ECharts through JavaScript interop; SignalR pushing new readings and alerts; acknowledgement from the web | A bUnit component test passes; a simulated alert appears on screen within seconds |
| 13. Flutter alarm app | Sign-in with OpenID Connect; Firebase Cloud Messaging; an alert list; a looping full-screen alarm on Android through a small Kotlin piece; "I'm on it" through the API; delivery confirmation | On a real Android phone on silent, with the app closed, a simulated critical alert sounds the alarm |

### Part D — AI and data

| Stage | You build | Done when |
| --- | --- | --- |
| 14. AI model | Features in SQL; a scikit-learn Isolation Forest trained in Jupyter on simulated healthy data; runs tracked in MLflow; exported to ONNX; run in the Evaluation host with ONNX Runtime in shadow mode (logged, no alert) | A test feeds an abnormal pattern and the model flags it; Python and C# produce the same feature values |
| 15. Data lake | SeaweedFS in Aspire; a nightly PyIceberg job copying readings, alerts and outcomes into Iceberg tables; DuckDB queries in Jupyter; deleting one demo business | DuckDB returns last week's readings; after the deletion, that business is gone from current and older snapshots |

### Part E — Production skills

| Stage | You build | Done when |
| --- | --- | --- |
| 16. Observability | OpenTelemetry in every host through ServiceDefaults; traces in the Aspire dashboard; later Prometheus, Grafana and Loki in the cluster | One trace shows a reading's whole path from ingestion to notification, with timings |
| 17. Containers and Kubernetes | Container images with `dotnet publish`; a k3d cluster on your Mac; a Helm chart per host; CloudNativePG (with a TimescaleDB image) and the RabbitMQ Cluster Operator; Traefik; kube-prometheus-stack | FarmLab runs fully in k3d; deleting an Evaluation pod loses no alert |
| 18. Delivery and security | GitHub Actions building, testing, scanning with Trivy, producing a software bill of materials and pushing images to GitHub's registry; Argo CD deploying from Git; SOPS and age for secrets; Renovate | Merging a pull request deploys automatically; a deliberately vulnerable package fails the build |

MassTransit: use version 9 if Chembiotech's free licence is approved by stage 9; otherwise version 8, whose API is nearly the same. Duende IdentityServer runs without a licence for development and testing, logging only a reminder ([Duende licensing](https://docs.duendesoftware.com/general/licensing/)).

## 6. Mac setup checklist

Install these in stage 0, and the later groups when you reach their stage. Commands assume an Apple silicon Mac (check under Apple menu > About This Mac) and Homebrew.

**Stage 0: basics**

- [ ] Homebrew, from brew.sh
- [ ] Git and the GitHub CLI: `brew install git gh`, then `gh auth login`
- [ ] .NET 10 SDK, the macOS Arm64 installer from Microsoft; check with `dotnet --list-sdks`
- [ ] An editor: JetBrains Rider, free for non-commercial use such as this training ([JetBrains](https://blog.jetbrains.com/blog/2024/10/24/webstorm-and-rider-are-now-free-for-non-commercial-use/)), or VS Code with the C# Dev Kit; FarmAI itself is commercial work and needs a suitable licence
- [ ] Docker Desktop for Mac; check Docker's terms for company use, or use Colima as a free alternative
- [ ] A database tool: DBeaver Community or Rider's built-in database view

**Stage 5: FarmLab core**

- [ ] Aspire CLI: `curl -sSL https://aspire.dev/install.sh | bash` ([Aspire 13](https://devblogs.microsoft.com/aspire/aspire13/))
- [ ] MQTTX, a desktop MQTT client for watching device messages (stage 8)

**Stage 13: mobile**

- [ ] Flutter SDK, from docs.flutter.dev
- [ ] Xcode from the App Store, plus CocoaPods: `brew install cocoapods`
- [ ] Android Studio with the Android SDK and an emulator
- [ ] A real Android phone with developer mode on, for alarm tests
- [ ] A Firebase project and the FlutterFire CLI: `dart pub global activate flutterfire_cli`

**Stage 14: AI and data**

- [ ] Python through uv: `brew install uv`, then `uv python install 3.12`
- [ ] JupyterLab, MLflow, scikit-learn, skl2onnx, PyIceberg and DuckDB, installed per project with `uv add`

**Stage 17: Kubernetes and delivery**

- [ ] `brew install kubectl k3d helm k9s argocd sops age trivy`

## 7. How to build it in the other tab

The other Claude session remembers nothing between sessions, so the rules live in the project folder. This Markdown copy of the guide is saved at `UserRegistrationApp/docs/FarmLab-Guide.md`; move it to `FarmLab/docs/` in stage 5.

**Working rules**

1. One stage at a time, split into tasks that each fit one pull request.
2. For every task, Claude explains the idea and proposes a plan; you approve before any code changes.
3. Tests first, then code; never move on with a failing test.
4. You write the core code (C#, EF Core, rules, messaging) with hints, and Claude reviews it. Claude writes the boilerplate (project files, Docker, Helm, CI) and explains it.
5. After each stage, add two or three lines to `docs/learning-log.md` and tick the stage's done-check.

**`CLAUDE.md`** — create this file in the project root in stage 0, and copy it to FarmLab in stage 5:

```markdown
# FarmLab — working rules for Claude

- Purpose: a training app for learning FarmAI's stack. The user is learning: explain before coding.
- Guide: docs/FarmLab-Guide.md (stages, layout, conventions). Current stage: docs/learning-log.md.
- One task at a time, small enough for one pull request. Propose the plan and wait for approval.
- Tests first: write a failing test, then the code. Never leave failing tests.
- Core concepts: the user writes the code; give hints, then review. Boilerplate: write it and explain it.
- Follow the guide's conventions: .NET 10, nullable, warnings as errors, central packages,
  one database schema per module, BusinessId on every business table, UTC times.
- Modules talk only through their .Contracts project or messages; never another module's tables.
- Never commit secrets; use .NET user-secrets locally.
- After each task, suggest two or three lines for docs/learning-log.md.
```

**First prompt to paste** in the other tab, opened on the UserRegistrationApp folder:

```text
I am learning the FarmAI stack by building a training app, step by step.
Read docs/FarmLab-Guide.md first, and follow the working rules in its section 7.
We are starting stage 0 in this folder. Explain the goal of stage 0, list the tasks
as small pull-request-sized steps, and wait for my go-ahead before changing anything.
```

## 8. Official learning resources

Use the official documentation first; it is current and matches the versions FarmAI uses.

| Area | Resource |
| --- | --- |
| C# | [C# documentation](https://learn.microsoft.com/dotnet/csharp/) |
| ASP.NET Core | [ASP.NET Core documentation](https://learn.microsoft.com/aspnet/core/) |
| EF Core | [Entity Framework Core](https://learn.microsoft.com/ef/core/) and the [Npgsql EF Core provider](https://www.npgsql.org/efcore/) |
| Accounts | [ASP.NET Core Identity](https://learn.microsoft.com/aspnet/core/security/authentication/identity) |
| Sign-in | [Duende IdentityServer documentation](https://docs.duendesoftware.com/) |
| Blazor and SignalR | [Blazor](https://learn.microsoft.com/aspnet/core/blazor/), [SignalR](https://learn.microsoft.com/aspnet/core/signalr/introduction), [MudBlazor](https://mudblazor.com/), [Apache ECharts](https://echarts.apache.org/) |
| Local orchestration | [Aspire](https://aspire.dev/) |
| Messaging | [RabbitMQ MQTT plugin](https://www.rabbitmq.com/docs/mqtt), [MassTransit](https://masstransit.massient.com/), [Quartz.NET](https://www.quartz-scheduler.net/documentation/) |
| Time series and cache | [TimescaleDB (Tiger Data)](https://docs.tigerdata.com/), [Valkey](https://valkey.io/docs/) |
| Testing | [xUnit](https://xunit.net/), [Testcontainers for .NET](https://dotnet.testcontainers.org/) |
| Mobile | [Flutter](https://docs.flutter.dev/), [Firebase Cloud Messaging for Flutter](https://firebase.flutter.dev/docs/messaging/overview) |
| AI | [scikit-learn](https://scikit-learn.org/), [MLflow](https://mlflow.org/docs/latest/), [ONNX Runtime for C#](https://onnxruntime.ai/docs/get-started/with-csharp.html) |
| Data lake | [PyIceberg](https://py.iceberg.apache.org/), [DuckDB with Iceberg](https://duckdb.org/docs/current/core_extensions/iceberg/writing), [SeaweedFS](https://github.com/seaweedfs/seaweedfs/wiki) |
| Observability | [OpenTelemetry for .NET](https://opentelemetry.io/docs/languages/dotnet/) |
| Kubernetes | [Kubernetes](https://kubernetes.io/docs/home/), [k3d](https://k3d.io/), [Helm](https://helm.sh/docs/), [CloudNativePG](https://cloudnative-pg.io/documentation/), [Traefik](https://doc.traefik.io/traefik/) |
| Delivery | [GitHub Actions](https://docs.github.com/actions), [Argo CD](https://argo-cd.readthedocs.io/), [Trivy](https://trivy.dev/) |
