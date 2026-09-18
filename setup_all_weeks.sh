#!/usr/bin/env bash
set -e

REPO="MdNoman1538/ReLearnDotNet"
PROJECT_TITLE="ReLearnDotNet Tracker"

echo "=== 1. Ensuring Labels ==="
gh label create "type:daily-target" --color "0E8A16" --description "Daily target task" --repo "$REPO" 2>/dev/null || true
gh label create "area:csharp"       --color "1D76DB" --description "Language & Runtime"   --repo "$REPO" 2>/dev/null || true
gh label create "area:aspnetcore"   --color "5319E7" --description "Web API & Pipeline"   --repo "$REPO" 2>/dev/null || true
gh label create "area:efcore"       --color "B60205" --description "EF Core Persistence"  --repo "$REPO" 2>/dev/null || true
gh label create "area:docker"       --color "0db7ed" --description "Containers & Linux"   --repo "$REPO" 2>/dev/null || true
gh label create "area:azure-compute"--color "FBCA04" --description "App Service & Functions" --repo "$REPO" 2>/dev/null || true
gh label create "area:azure-storage"--color "D93F0B" --description "Blobs & Cosmos DB"    --repo "$REPO" 2>/dev/null || true
gh label create "area:azure-messaging" --color "E99695" --description "Service Bus & Events" --repo "$REPO" 2>/dev/null || true
gh label create "area:azure-security"  --color "0052CC" --description "Identity & Key Vault" --repo "$REPO" 2>/dev/null || true
gh label create "area:observability"   --color "5C2D91" --description "Logging & App Insights" --repo "$REPO" 2>/dev/null || true
gh label create "area:capstone"     --color "FF5722" --description "End-to-end integration" --repo "$REPO" 2>/dev/null || true

echo "=== 2. Creating Milestones (Sprints 01 - 12) ==="
declare -A MILESTONES=(
  ["01"]="Sprint 01: Modern C# & Async Internals"
  ["02"]="Sprint 02: ASP.NET Core Request Pipeline & DI"
  ["03"]="Sprint 03: EF Core Modernization & Resiliency"
  ["04"]="Sprint 04: Dockerizing .NET & Linux Containers"
  ["05"]="Sprint 05: Azure App Services & CI/CD Slots"
  ["06"]="Sprint 06: Serverless Azure Functions & Triggers"
  ["07"]="Sprint 07: Azure Blob Storage & Cosmos DB SDK"
  ["08"]="Sprint 08: Azure Service Bus & Event-Driven Systems"
  ["09"]="Sprint 09: Azure API Management (APIM)"
  ["10"]="Sprint 10: Managed Identity & Key Vault Security"
  ["11"]="Sprint 11: Redis Distributed Cache & App Insights"
  ["12"]="Sprint 12: Cloud-Native Capstone & AZ-204 Prep"
)

for key in "${!MILESTONES[@]}"; do
  gh api "repos/$REPO/milestones" -f title="${MILESTONES[$key]}" 2>/dev/null || true
done

echo "=== 3. Populating All 84 Daily Target Issues ==="

create_task() {
  local title="$1"
  local milestone="$2"
  local labels="$3"
  local body="$4"

  gh issue create -R "$REPO" \
    --title "$title" \
    --body "$body" \
    --milestone "$milestone" \
    --label "$labels" \
    --project "$PROJECT_TITLE" \
    --assignee "@me" > /dev/null
  echo "Created: $title"
}

# ----------------- SPRINT 01 -----------------
M="${MILESTONES["01"]}"
create_task "Day 01: Records, Primary Constructors & Value Equality" "$M" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Migrate legacy POCOs to \`record\` and \`record struct\`
- [ ] Implement non-destructive mutation with \`with\` expressions
- [ ] Lab: Create an immutable domain model in \`src/week-01/Day01\`"

create_task "Day 02: Pattern Matching & Switch Expressions" "$M" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Replace nested if/else with property and relational patterns
- [ ] Implement switch expressions with \`when\` guards
- [ ] Lab: Write a state validator in \`src/week-01/Day02\`"

create_task "Day 03: Nullable Reference Types & Static Safety" "$M" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Enable \`<Nullable>enable</Nullable>\` and \`<TreatWarningsAsErrors>true</TreatWarningsAsErrors>\`
- [ ] Eliminate nullability warnings without blind \`!\` operators"

create_task "Day 04: Async Pipeline Internals, Task vs ValueTask" "$M" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Audit and remove sync-over-async (.Result, .Wait()) anti-patterns
- [ ] Benchmark high-throughput allocations: \`Task<T>\` vs \`ValueTask<T>\`"

create_task "Day 05: CancellationTokens & Cooperative Cancellation" "$M" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Thread \`CancellationToken\` through controllers down to EF Core/HTTP calls
- [ ] Verify cancellation terminates downstream operations"

create_task "Day 06: Zero-Allocation Parsing (Span<T> & Memory<T>)" "$M" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Learn slicing semantics with \`ReadOnlySpan<char>\`
- [ ] Benchmark zero-allocation string parsing"

create_task "Day 07: Sprint 01 Review & Retrospective" "$M" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Consolidate notes in \`docs/notes/week-01.md\`
- [ ] Review PRs and close Sprint 01"

# ----------------- SPRINT 02 -----------------
M="${MILESTONES["02"]}"
create_task "Day 08: Program.cs, Generic Host & Middleware" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Replace Global.asax with custom middleware pipeline
- [ ] Build global error-handling and correlation-ID middleware"

create_task "Day 09: Dependency Injection Scopes & Captive Pitfalls" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Compare Transient, Scoped, and Singleton lifetimes
- [ ] Configure \`ValidateScopes\` to detect captive dependencies"

create_task "Day 10: Strongly-Typed Options Pattern" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Bind config sections using \`IOptions<T>\` and \`IOptionsSnapshot<T>\`
- [ ] Implement \`ValidateOnStart()\` with DataAnnotations"

create_task "Day 11: Minimal APIs Architecture" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Build CRUD endpoints via \`MapGroup\` and \`TypedResults\`
- [ ] Implement endpoint filters for validation and authorization"

create_task "Day 12: ProblemDetails (RFC 7807) & Validation" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Configure standard \`ProblemDetails\` for API errors
- [ ] Integrate FluentValidation filters into the request pipeline"

create_task "Day 13: Structured Logging with Serilog" "$M" "type:daily-target,area:aspnetcore,area:observability" \
"### Objectives
- [ ] Replace flat-text logs with Serilog structured JSON events
- [ ] Inject contextual properties into log scopes"

create_task "Day 14: Sprint 02 Review & Retrospective" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Consolidate notes in \`docs/notes/week-02.md\`
- [ ] Merge open PRs and close Sprint 02"

# ----------------- SPRINT 03 -----------------
M="${MILESTONES["03"]}"
create_task "Day 15: EF Core Architecture vs EF 6" "$M" "type:daily-target,area:efcore" \
"### Objectives
- [ ] Configure \`DbContextOptionsBuilder\` and DbContext pooling
- [ ] Use Fluent API over DataAnnotations for model mapping"

create_task "Day 16: EF Core Migrations CLI & CI Automation" "$M" "type:daily-target,area:efcore" \
"### Objectives
- [ ] Master \`dotnet ef migrations add\` and idempotent script generation
- [ ] Understand automated migration risks in production"

create_task "Day 17: Query Performance & No-Tracking Semantics" "$M" "type:daily-target,area:efcore" \
"### Objectives
- [ ] Use \`AsNoTracking\` and \`AsNoTrackingWithIdentityResolution\`
- [ ] Avoid N+1 query traps using explicit projections"

create_task "Day 18: Compiled Queries & Raw SQL Mapping" "$M" "type:daily-target,area:efcore" \
"### Objectives
- [ ] Implement \`EF.CompileAsyncQuery\` for read-heavy routes
- [ ] Execute safe parameterized queries with \`FromSqlInterpolated\`"

create_task "Day 19: Connection Resiliency & Execution Strategies" "$M" "type:daily-target,area:efcore" \
"### Objectives
- [ ] Configure \`EnableRetryOnFailure\` for transient cloud errors
- [ ] Handle custom transactions inside execution strategies"

create_task "Day 20: DbContext Interceptors & Soft Deletes" "$M" "type:daily-target,area:efcore" \
"### Objectives
- [ ] Create a \`SaveChangesInterceptor\` for automated audit tracking
- [ ] Configure Global Query Filters for soft deletes"

create_task "Day 21: Sprint 03 Review & Retrospective" "$M" "type:daily-target,area:efcore" \
"### Objectives
- [ ] Document EF Core patterns in \`docs/notes/week-03.md\`
- [ ] Close Sprint 03"

# ----------------- SPRINT 04 -----------------
M="${MILESTONES["04"]}"
create_task "Day 22: Linux Container Fundamentals for .NET" "$M" "type:daily-target,area:docker" \
"### Objectives
- [ ] Understand Linux cgroups, namespaces, and runtime images
- [ ] Contrast Windows containers with modern Linux .NET hosting"

create_task "Day 23: Multi-Stage Dockerfile Optimization" "$M" "type:daily-target,area:docker" \
"### Objectives
- [ ] Author multi-stage builds separating SDK from runtime
- [ ] Minimize image footprint using Chiseled Ubuntu / Alpine images"

create_task "Day 24: Container Health Checks & Non-Root Users" "$M" "type:daily-target,area:docker" \
"### Objectives
- [ ] Run container workloads as non-root user (\`USER \$APP_UID\`)
- [ ] Implement \`/healthz\` checks inside Docker container config"

create_task "Day 25: Local Multi-Container Spikes (Docker Compose)" "$M" "type:daily-target,area:docker" \
"### Objectives
- [ ] Spin up Web API + SQL Server Linux container via Docker Compose
- [ ] Configure persistent volumes and internal network DNS"

create_task "Day 26: Azure Container Registry (ACR) Setup" "$M" "type:daily-target,area:docker,area:azure-compute" \
"### Objectives
- [ ] Create private ACR instance via Azure CLI
- [ ] Tag, push, and version .NET Docker images using semantic tags"

create_task "Day 27: Deploying to Azure Container Apps (ACA)" "$M" "type:daily-target,area:docker,area:azure-compute" \
"### Objectives
- [ ] Deploy container from ACR to Azure Container Apps
- [ ] Configure KEDA-based automatic scaling rules"

create_task "Day 28: Sprint 04 Review & Retrospective" "$M" "type:daily-target,area:docker" \
"### Objectives
- [ ] Write Docker & Container notes in \`docs/notes/week-04.md\`
- [ ] Close Sprint 04"

# ----------------- SPRINT 05 -----------------
M="${MILESTONES["05"]}"
create_task "Day 29: Azure App Service on Linux" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Create Linux App Service Plan and Web App via Azure CLI
- [ ] Deploy .NET 8 published artifact via zip deploy"

create_task "Day 30: Deployment Slots & Zero-Downtime Swaps" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Provision staging and production deployment slots
- [ ] Perform slot swap with pre-warming"

create_task "Day 31: App Service Configuration & App Settings" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Override appsettings.json using Azure App Service App Settings
- [ ] Understand slot-specific configuration (sticky settings)"

create_task "Day 32: Autoscaling & Health Probes in App Service" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Configure scale-out rules based on CPU and memory thresholds
- [ ] Integrate Health Check paths to automatically remove unhealthy instances"

create_task "Day 33: Custom Domains & Managed TLS/SSL Certificates" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Bind custom domain names and configure DNS records (TXT/CNAME)
- [ ] Bind free Azure App Service Managed SSL Certificates"

create_task "Day 34: CI/CD Pipeline to App Service with GitHub Actions" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Write GitHub Actions workflow to build, test, and deploy to staging slot
- [ ] Add automated smoke test step before slot swap"

create_task "Day 35: Sprint 05 Review & Retrospective" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Document App Service deployment flow in \`docs/notes/week-05.md\`
- [ ] Close Sprint 05"

# ----------------- SPRINT 06 -----------------
M="${MILESTONES["06"]}"
create_task "Day 36: Isolated Worker Model in Azure Functions" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Contrast in-process vs isolated worker models
- [ ] Configure \`Program.cs\` host builder in Azure Functions v4"

create_task "Day 37: HTTP Triggers & Authorization Levels" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Build HTTP-triggered functions using \`HttpRequestData\` / \`HttpResponseData\`
- [ ] Evaluate Anonymous, Function, and Admin auth levels"

create_task "Day 38: Timer & Schedule Triggers (NCRONTAB)" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Create periodic background functions with NCRONTAB expressions
- [ ] Test timer execution locally and handle transient clock drift"

create_task "Day 39: Blob & Queue Storage Triggers with Bindings" "$M" "type:daily-target,area:azure-compute,area:azure-storage" \
"### Objectives
- [ ] Configure declarative input/output bindings
- [ ] Trigger functions on new blob creation and write output messages"

create_task "Day 40: Durable Functions Orchestrations" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Understand Orchestrator, Activity, and Client functions
- [ ] Implement the Function Chaining pattern"

create_task "Day 41: Durable Functions Fan-Out / Fan-In" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Implement parallel processing with Fan-Out / Fan-In
- [ ] Manage deterministic execution constraints in orchestrators"

create_task "Day 42: Sprint 06 Review & Retrospective" "$M" "type:daily-target,area:azure-compute" \
"### Objectives
- [ ] Document serverless patterns in \`docs/notes/week-06.md\`
- [ ] Close Sprint 06"

# ----------------- SPRINT 07 -----------------
M="${MILESTONES["07"]}"
create_task "Day 43: Azure Blob Storage SDK Essentials" "$M" "type:daily-target,area:azure-storage" \
"### Objectives
- [ ] Use \`Azure.Storage.Blobs\` SDK for container and blob lifecycle
- [ ] Stream large file uploads without loading full payload into memory"

create_task "Day 44: Blob Storage Security & SAS Tokens" "$M" "type:daily-target,area:azure-storage" \
"### Objectives
- [ ] Generate time-limited Shared Access Signature (SAS) tokens
- [ ] Implement Stored Access Policies for instant token revocation"

create_task "Day 45: Azure Cosmos DB Architecture & Partitioning" "$M" "type:daily-target,area:azure-storage" \
"### Objectives
- [ ] Learn partition key design to prevent hot partitions
- [ ] Understand Request Units (RUs) and provisioned vs serverless billing"

create_task "Day 46: Cosmos DB .NET SDK v3 Operations" "$M" "type:daily-target,area:azure-storage" \
"### Objectives
- [ ] Perform point reads vs SQL queries using \`CosmosClient\`
- [ ] Configure bulk execution mode for mass data ingestion"

create_task "Day 47: Cosmos DB Consistency Levels" "$M" "type:daily-target,area:azure-storage" \
"### Objectives
- [ ] Analyze the 5 consistency levels (Strong to Eventual)
- [ ] Implement Session Consistency in web application clients"

create_task "Day 48: Cosmos DB Change Feed Processing" "$M" "type:daily-target,area:azure-storage,area:azure-compute" \
"### Objectives
- [ ] Implement Change Feed Processor via Azure Functions trigger
- [ ] Propagate state changes reactively to downstream services"

create_task "Day 49: Sprint 07 Review & Retrospective" "$M" "type:daily-target,area:azure-storage" \
"### Objectives
- [ ] Document Storage & NoSQL designs in \`docs/notes/week-07.md\`
- [ ] Close Sprint 07"

# ----------------- SPRINT 08 -----------------
M="${MILESTONES["08"]}"
create_task "Day 50: Azure Service Bus Queues & Dead-Lettering" "$M" "type:daily-target,area:azure-messaging" \
"### Objectives
- [ ] Send and process messages using \`ServiceBusClient\` / \`ServiceBusProcessor\`
- [ ] Configure dead-letter queues (DLQ) and max delivery counts"

create_task "Day 51: Service Bus Topics, Subscriptions & Filters" "$M" "type:daily-target,area:azure-messaging" \
"### Objectives
- [ ] Implement publish-subscribe architecture with Topics
- [ ] Use SQL filters and correlation filters for subscription routing"

create_task "Day 52: Message Sessions & FIFO Ordering" "$M" "type:daily-target,area:azure-messaging" \
"### Objectives
- [ ] Enable Session IDs on queues for guaranteed in-order processing
- [ ] Implement concurrent session processors"

create_task "Day 53: Azure Event Grid for Reactive System Events" "$M" "type:daily-target,area:azure-messaging" \
"### Objectives
- [ ] Create custom Event Grid topics
- [ ] Handle system events (e.g. BlobCreated) via webhook subscribers"

create_task "Day 54: Azure Event Hubs for High-Throughput Ingestion" "$M" "type:daily-target,area:azure-messaging" \
"### Objectives
- [ ] Differentiate Event Hubs (streaming) from Service Bus (enterprise messaging)
- [ ] Ingest telemetry data using \`EventHubProducerClient\`"

create_task "Day 55: Event Processor Host & Consumer Groups" "$M" "type:daily-target,area:azure-messaging" \
"### Objectives
- [ ] Process streaming partitions using Storage Blob checkpointing
- [ ] Handle re-balancing and backpressure"

create_task "Day 56: Sprint 08 Review & Retrospective" "$M" "type:daily-target,area:azure-messaging" \
"### Objectives
- [ ] Document messaging patterns in \`docs/notes/week-08.md\`
- [ ] Close Sprint 08"

# ----------------- SPRINT 09 -----------------
M="${MILESTONES["09"]}"
create_task "Day 57: Azure API Management (APIM) Architecture" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Provision APIM instance and map backend endpoints
- [ ] Import OpenAPI / Swagger specifications from .NET APIs"

create_task "Day 58: APIM Inbound Policies (Rate Limiting & Headers)" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Author XML inbound policies for rate limiting (rate-limit-by-key)
- [ ] Enforce CORS policies and rewrite URL structures"

create_task "Day 59: Token Validation with APIM" "$M" "type:daily-target,area:azure-security" \
"### Objectives
- [ ] Implement \`validate-jwt\` policy in APIM
- [ ] Verify claims, issuer, and audience before traffic hits backend"

create_task "Day 60: APIM Caching & Response Transformation" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Configure response caching policies in APIM
- [ ] Transform XML payloads to modern JSON using Liquid templates"

create_task "Day 61: APIM Products, Subscriptions & Developer Portal" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Group APIs into Starter and Unlimited Products
- [ ] Enforce subscription keys and test developer portal workflows"

create_task "Day 62: Mocking & Backend Circuit Breakers in APIM" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Configure mock response policies for frontend decoupling
- [ ] Implement circuit breaker policies for backend resilience"

create_task "Day 63: Sprint 09 Review & Retrospective" "$M" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Document APIM routing in \`docs/notes/week-09.md\`
- [ ] Close Sprint 09"

# ----------------- SPRINT 10 -----------------
M="${MILESTONES["10"]}"
create_task "Day 64: Azure Key Vault & Secrets Management" "$M" "type:daily-target,area:azure-security" \
"### Objectives
- [ ] Create Key Vault and store database credentials securely
- [ ] Connect .NET Configuration Provider to Key Vault directly"

create_task "Day 65: Managed Identities (System-Assigned & User-Assigned)" "$M" "type:daily-target,area:azure-security" \
"### Objectives
- [ ] Eliminate credentials in code using \`DefaultAzureCredential\`
- [ ] Assign Azure RBAC roles (Key Vault Secrets User, Storage Blob Data Contributor)"

create_task "Day 66: Azure App Configuration & Dynamic Refresh" "$M" "type:daily-target,area:azure-security" \
"### Objectives
- [ ] Centralize application settings in Azure App Configuration
- [ ] Implement dynamic feature flags and refresh without application restart"

create_task "Day 67: Microsoft Entra ID Authentication in ASP.NET Core" "$M" "type:daily-target,area:azure-security" \
"### Objectives
- [ ] Register App Registrations in Microsoft Entra ID
- [ ] Secure Minimal APIs using \`Microsoft.Identity.Web\` and Bearer tokens"

create_task "Day 68: Role-Based & Scope-Based Authorization" "$M" "type:daily-target,area:azure-security" \
"### Objectives
- [ ] Authorize requests by checking token scopes (\`scp\`) and app roles
- [ ] Implement custom authorization policy handlers in C#"

create_task "Day 69: Service-to-Service Authentication via Client Credentials" "$M" "type:daily-target,area:azure-security" \
"### Objectives
- [ ] Implement OAuth 2.0 Client Credentials Grant flow
- [ ] Use MSAL.NET to acquire tokens and query downstream APIs"

create_task "Day 70: Sprint 10 Review & Retrospective" "$M" "type:daily-target,area:azure-security" \
"### Objectives
- [ ] Document cloud identity & security in \`docs/notes/week-10.md\`
- [ ] Close Sprint 10"

# ----------------- SPRINT 11 -----------------
M="${MILESTONES["11"]}"
create_task "Day 71: Distributed Caching with Azure Cache for Redis" "$M" "type:daily-target,area:observability" \
"### Objectives
- [ ] Provision Redis instance and connect via \`StackExchange.Redis\`
- [ ] Implement \`IDistributedCache\` with Cache-Aside pattern"

create_task "Day 72: Redis Data Structures & Pub/Sub" "$M" "type:daily-target,area:observability" \
"### Objectives
- [ ] Leverage Redis Sets and Sorted Sets for high-performance lookups
- [ ] Implement lightweight messaging via Redis Pub/Sub"

create_task "Day 73: Application Insights Instrumentation" "$M" "type:daily-target,area:observability" \
"### Objectives
- [ ] Add \`Microsoft.ApplicationInsights.AspNetCore\` SDK
- [ ] Track unhandled exceptions, page views, and API response times"

create_task "Day 74: Distributed Tracing & Correlation Across Services" "$M" "type:daily-target,area:observability" \
"### Objectives
- [ ] Propagate W3C TraceContext headers across HTTP and Service Bus calls
- [ ] Inspect end-to-end transaction maps in Application Insights"

create_task "Day 75: Custom Telemetry & OpenTelemetry Metrics" "$M" "type:daily-target,area:observability" \
"### Objectives
- [ ] Instrument code using \`TelemetryClient\` for custom events and metrics
- [ ] Export standard .NET Meter metrics to Azure Monitor"

create_task "Day 76: Kusto Query Language (KQL) for Log Analytics" "$M" "type:daily-target,area:observability" \
"### Objectives
- [ ] Author KQL queries across \`requests\`, \`dependencies\`, and \`exceptions\`
- [ ] Create Log Analytics alert rules based on exception thresholds"

create_task "Day 77: Sprint 11 Review & Retrospective" "$M" "type:daily-target,area:observability" \
"### Objectives
- [ ] Document monitoring practices in \`docs/notes/week-11.md\`
- [ ] Close Sprint 11"

# ----------------- SPRINT 12 -----------------
M="${MILESTONES["12"]}"
create_task "Day 78: Capstone Architecture Design & Solution Layout" "$M" "type:daily-target,area:capstone" \
"### Objectives
- [ ] Architect end-to-end system: Minimal API + Service Bus + Function + Cosmos DB
- [ ] Configure local solution with Clean Architecture layers"

create_task "Day 79: Capstone Ingestion API & Service Bus Publisher" "$M" "type:daily-target,area:capstone" \
"### Objectives
- [ ] Implement secure POST API endpoint with FluentValidation
- [ ] Publish messages to Azure Service Bus using Managed Identity"

create_task "Day 80: Capstone Processing Function & Cosmos DB Sink" "$M" "type:daily-target,area:capstone" \
"### Objectives
- [ ] Build isolated Azure Function to process Service Bus queue items
- [ ] Persist processed records into Cosmos DB with partition key"

create_task "Day 81: Capstone Observability & Redis Caching" "$M" "type:daily-target,area:capstone" \
"### Objectives
- [ ] Add Redis cache for read endpoints
- [ ] Verify complete distributed trace in Application Insights"

create_task "Day 82: Capstone GitHub Actions CI/CD to Azure" "$M" "type:daily-target,area:capstone" \
"### Objectives
- [ ] Automate build, test, and deploy pipeline via GitHub Actions
- [ ] Deploy containerized API to ACA and Function to Azure"

create_task "Day 83: AZ-204 Practice Exam & Weak Spot Remediation" "$M" "type:daily-target,area:capstone" \
"### Objectives
- [ ] Complete Microsoft Learn official AZ-204 practice assessment
- [ ] Review any weak areas in compute, storage, or security"

create_task "Day 84: 12-Week Retrospective & Certification Readiness" "$M" "type:daily-target,area:capstone" \
"### Objectives
- [ ] Write final retrospective in \`README.md\`
- [ ] Tag repository \`v1.0.0\`
- [ ] Schedule AZ-204 examination"

echo "=== Successfully populated all 84 daily tasks! ==="
