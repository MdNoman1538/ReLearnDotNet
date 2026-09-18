#!/usr/bin/env bash
REPO="MdNoman1538/ReLearnDotNet"
PROJECT_ID=1

echo "Ensuring labels exist..."
gh label create "type:daily-target" --color "0E8A16" -R "$REPO" 2>/dev/null || true
gh label create "area:csharp" --color "1D76DB" -R "$REPO" 2>/dev/null || true
gh label create "area:aspnetcore" --color "5319E7" -R "$REPO" 2>/dev/null || true
gh label create "area:azure" --color "0052CC" -R "$REPO" 2>/dev/null || true

echo "Starting 84-day curriculum generation..."

create_task() {
  local title="$1"
  local labels="$2"
  local body="$3"

  # 1. Create the issue and capture the URL
  ISSUE_URL=$(gh issue create -R "$REPO" --title "$title" --body "$body" --label "$labels" --assignee "@me")
  
  # 2. If successful, link it to your Project V2 Board
  if [[ $ISSUE_URL == http* ]]; then
    gh project item-add $PROJECT_ID --owner "@me" --url "$ISSUE_URL" > /dev/null
    echo "Created & Linked: $title"
  else
    echo "Failed to create: $title"
  fi
}

# ==========================================
# PHASE 1: MODERN .NET & C# (Weeks 1-3)
# ==========================================
create_task "Day 01: Records, Primary Constructors & Value Equality" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Migrate legacy POCOs to \`record\` and \`record struct\`
- [ ] Implement non-destructive mutation with \`with\` expressions
- [ ] Lab: Create an immutable domain model in \`src/week-01/Day01\`"

create_task "Day 02: Pattern Matching & Switch Expressions" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Replace nested if/else with property and relational patterns
- [ ] Implement switch expressions with \`when\` guards"

create_task "Day 03: Nullable Reference Types & Static Safety" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Enable \`<Nullable>enable</Nullable>\` in .csproj
- [ ] Eliminate nullability warnings without blind \`!\` operators"

create_task "Day 04: Async Pipeline Internals, Task vs ValueTask" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Audit and remove sync-over-async (.Result, .Wait()) anti-patterns
- [ ] Benchmark allocations: \`Task<T>\` vs \`ValueTask<T>\`"

create_task "Day 05: Cooperative Cancellation via CancellationToken" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Thread \`CancellationToken\` through controllers to EF Core
- [ ] Verify cancellation terminates downstream database operations"

create_task "Day 06: Zero-Allocation Parsing (Span & Memory)" "type:daily-target,area:csharp" \
"### Objectives
- [ ] Learn slicing semantics with \`ReadOnlySpan<char>\`
- [ ] Replace costly substring/array copies with Span-based parsers"

create_task "Day 07: Week 01 Review & Retrospective" "type:daily-target" \
"### Objectives
- [ ] Consolidate notes in \`docs/notes/week-01.md\`
- [ ] Setup ASP.NET Core branch for Week 02"

create_task "Day 08: Program.cs & Generic Host Middleware" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Replace Global.asax with custom middleware pipeline
- [ ] Build global error-handling and correlation-ID middleware"

create_task "Day 09: Dependency Injection & Captive Dependencies" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Compare Transient, Scoped, and Singleton lifetimes
- [ ] Configure \`ValidateScopes\` to detect captive dependencies"

create_task "Day 10: Strongly-Typed Options Pattern" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Bind config sections using \`IOptions<T>\` and \`IOptionsSnapshot<T>\`
- [ ] Implement \`ValidateOnStart()\` with DataAnnotations"

create_task "Day 11: Minimal APIs Architecture" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Build CRUD endpoints via \`MapGroup\` and \`TypedResults\`
- [ ] Compare cold-start memory against MVC Controllers"

create_task "Day 12: ProblemDetails (RFC 7807) & Validation" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Configure standard \`ProblemDetails\` for API errors
- [ ] Integrate FluentValidation filters into the request pipeline"

create_task "Day 13: Structured Logging with Serilog" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Replace flat-text logs with Serilog structured JSON events
- [ ] Inject contextual properties into log scopes"

create_task "Day 14: Week 02 Review & Retrospective" "type:daily-target" \
"### Objectives
- [ ] Consolidate notes in \`docs/notes/week-02.md\`
- [ ] Prepare EF Core migration branch"

create_task "Day 15: EF Core Architecture vs EF 6" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Configure \`DbContextOptionsBuilder\` and DbContext pooling
- [ ] Use Fluent API over DataAnnotations for model mapping"

create_task "Day 16: EF Core Migrations CLI" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Master \`dotnet ef migrations add\`
- [ ] Generate idempotent SQL scripts for CI/CD pipelines"

create_task "Day 17: Query Performance & No-Tracking" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Use \`AsNoTracking\` for read-only operations
- [ ] Avoid N+1 query traps using explicit projections (.Select)"

create_task "Day 18: Compiled Queries & Raw SQL" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Implement \`EF.CompileAsyncQuery\` for read-heavy routes
- [ ] Execute safe parameterized queries with \`FromSqlInterpolated\`"

create_task "Day 19: Connection Resiliency" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Configure \`EnableRetryOnFailure\` for transient cloud errors
- [ ] Handle custom transactions inside execution strategies"

create_task "Day 20: DbContext Interceptors & Soft Deletes" "type:daily-target,area:aspnetcore" \
"### Objectives
- [ ] Create a \`SaveChangesInterceptor\` for automated audit tracking
- [ ] Configure Global Query Filters for soft deletes"

create_task "Day 21: Week 03 Review & Retrospective" "type:daily-target" \
"### Objectives
- [ ] Consolidate EF Core notes in \`docs/notes/week-03.md\`"

# ==========================================
# PHASE 2: COMPUTE & CONTAINERS (Weeks 4-6)
# ==========================================
create_task "Day 22: Linux Containers for .NET" "type:daily-target,area:azure" \
"### Objectives
- [ ] Understand Linux cgroups and runtime images
- [ ] Contrast Windows IIS hosting with modern Linux Kestrel hosting"

create_task "Day 23: Multi-Stage Dockerfile Optimization" "type:daily-target,area:azure" \
"### Objectives
- [ ] Author multi-stage builds separating SDK from runtime
- [ ] Minimize image footprint using Alpine/Chiseled images"

create_task "Day 24: Container Health Checks" "type:daily-target,area:azure" \
"### Objectives
- [ ] Run container workloads as non-root user
- [ ] Implement \`/healthz\` checks inside Docker container config"

create_task "Day 25: Local Multi-Container Spikes" "type:daily-target,area:azure" \
"### Objectives
- [ ] Spin up Web API + SQL Server via Docker Compose
- [ ] Configure persistent volumes and internal networking"

create_task "Day 26: Azure Container Registry (ACR)" "type:daily-target,area:azure" \
"### Objectives
- [ ] Create private ACR instance via Azure CLI
- [ ] Tag, push, and version .NET Docker images"

create_task "Day 27: Deploying to Azure Container Apps (ACA)" "type:daily-target,area:azure" \
"### Objectives
- [ ] Deploy container from ACR to Azure Container Apps
- [ ] Configure KEDA-based automatic scaling rules"

create_task "Day 28: Week 04 Review & Retrospective" "type:daily-target" \
"### Objectives
- [ ] Consolidate Container notes in \`docs/notes/week-04.md\`"

create_task "Day 29: Azure App Service on Linux" "type:daily-target,area:azure" \
"### Objectives
- [ ] Create Linux App Service Plan via Azure CLI
- [ ] Deploy .NET 8 published artifact via zip deploy"

create_task "Day 30: Deployment Slots & Zero-Downtime Swaps" "type:daily-target,area:azure" \
"### Objectives
- [ ] Provision staging and production deployment slots
- [ ] Perform slot swap with pre-warming"

create_task "Day 31: App Service Configuration" "type:daily-target,area:azure" \
"### Objectives
- [ ] Override appsettings.json using Azure App Service App Settings
- [ ] Understand slot-specific configuration (sticky settings)"

create_task "Day 32: Autoscaling & Health Probes" "type:daily-target,area:azure" \
"### Objectives
- [ ] Configure scale-out rules based on CPU/Memory
- [ ] Integrate Health Check paths to remove unhealthy instances"

create_task "Day 33: Custom Domains & SSL" "type:daily-target,area:azure" \
"### Objectives
- [ ] Bind custom domain names and configure DNS records
- [ ] Bind free Azure App Service Managed SSL Certificates"

create_task "Day 34: CI/CD Pipeline to App Service" "type:daily-target,area:azure" \
"### Objectives
- [ ] Write GitHub Actions workflow to build, test, and deploy
- [ ] Add automated smoke test step before slot swap"

create_task "Day 35: Week 05 Review & Retrospective" "type:daily-target" \
"### Objectives
- [ ] Consolidate App Service notes in \`docs/notes/week-05.md\`"

create_task "Day 36: Isolated Worker Model in Azure Functions" "type:daily-target,area:azure" \
"### Objectives
- [ ] Contrast in-process vs isolated worker models
- [ ] Configure \`Program.cs\` host builder in Azure Functions v4"

create_task "Day 37: HTTP Triggers & Authorization" "type:daily-target,area:azure" \
"### Objectives
- [ ] Build HTTP-triggered functions
- [ ] Evaluate Anonymous, Function, and Admin auth levels"

create_task "Day 38: Timer Triggers (NCRONTAB)" "type:daily-target,area:azure" \
"### Objectives
- [ ] Create periodic background functions with NCRONTAB
- [ ] Test timer execution locally"

create_task "Day 39: Blob & Queue Storage Bindings" "type:daily-target,area:azure" \
"### Objectives
- [ ] Configure declarative input/output bindings
- [ ] Trigger functions on new blob creation"

create_task "Day 40: Durable Functions Orchestrations" "type:daily-target,area:azure" \
"### Objectives
- [ ] Understand Orchestrator, Activity, and Client functions
- [ ] Implement the Function Chaining pattern"

create_task "Day 41: Durable Functions Fan-Out / Fan-In" "type:daily-target,area:azure" \
"### Objectives
- [ ] Implement parallel processing with Fan-Out / Fan-In
- [ ] Manage deterministic execution constraints"

create_task "Day 42: Week 06 Review & Retrospective" "type:daily-target" \
"### Objectives
- [ ] Consolidate Serverless notes in \`docs/notes/week-06.md\`"

# ==========================================
# PHASE 3: CLOUD STORAGE & MESSAGING (Weeks 7-9)
# ==========================================
create_task "Day 43: Azure Blob Storage SDK" "type:daily-target,area:azure" \
"### Objectives
- [ ] Use \`Azure.Storage.Blobs\` SDK for container lifecycle
- [ ] Stream large file uploads efficiently"

create_task "Day 44: Blob Security & SAS Tokens" "type:daily-target,area:azure" \
"### Objectives
- [ ] Generate time-limited Shared Access Signature (SAS) tokens
- [ ] Implement Stored Access Policies"

create_task "Day 45: Cosmos DB Architecture & Partitioning" "type:daily-target,area:azure" \
"### Objectives
- [ ] Learn partition key design to prevent hot partitions
- [ ] Understand Request Units (RUs) and serverless billing"

create_task "Day 46: Cosmos DB .NET SDK Operations" "type:daily-target,area:azure" \
"### Objectives
- [ ] Perform point reads vs SQL queries
- [ ] Configure bulk execution mode for mass data ingestion"

create_task "Day 47: Cosmos DB Consistency Levels" "type:daily-target,area:azure" \
"### Objectives
- [ ] Analyze the 5 consistency levels
- [ ] Implement Session Consistency in web application clients"

create_task "Day 48: Cosmos DB Change Feed" "type:daily-target,area:azure" \
"### Objectives
- [ ] Implement Change Feed Processor via Azure Functions
- [ ] Propagate state changes reactively"

create_task "Day 49: Week 07 Review & Retrospective" "type:daily-target" \
"### Objectives
- [ ] Consolidate Storage notes in \`docs/notes/week-07.md\`"

create_task "Day 50: Service Bus Queues & Dead-Lettering" "type:daily-target,area:azure" \
"### Objectives
- [ ] Send and process messages using \`ServiceBusClient\`
- [ ] Configure dead-letter queues (DLQ)"

create_task "Day 51: Service Bus Topics & Filters" "type:daily-target,area:azure" \
"### Objectives
- [ ] Implement publish-subscribe architecture
- [ ] Use SQL filters for subscription routing"

create_task "Day 52: Message Sessions & FIFO Ordering" "type:daily-target,area:azure" \
"### Objectives
- [ ] Enable Session IDs on queues for guaranteed in-order processing
- [ ] Implement concurrent session processors"

create_task "Day 53: Azure Event Grid" "type:daily-target,area:azure" \
"### Objectives
- [ ] Create custom Event Grid topics
- [ ] Handle system events via webhook subscribers"

create_task "Day 54: Azure Event Hubs" "type:daily-target,area:azure" \
"### Objectives
- [ ] Differentiate Event Hubs (streaming) from Service Bus
- [ ] Ingest telemetry data using \`EventHubProducerClient\`"

create_task "Day 55: Event Processor Host" "type:daily-target,area:azure" \
"### Objectives
- [ ] Process streaming partitions using Storage Blob checkpointing
- [ ] Handle re-balancing and backpressure"

create_task "Day 56: Week 08 Review & Retrospective" "type:daily-target" \
"### Objectives
- [ ] Consolidate Messaging notes in \`docs/notes/week-08.md\`"

create_task "Day 57: Azure API Management (APIM) Architecture" "type:daily-target,area:azure" \
"### Objectives
- [ ] Provision APIM instance and map backend endpoints
- [ ] Import OpenAPI specifications from .NET APIs"

create_task "Day 58: APIM Inbound Policies" "type:daily-target,area:azure" \
"### Objectives
- [ ] Author XML inbound policies for rate limiting
- [ ] Enforce CORS policies and rewrite URLs"

create_task "Day 59: Token Validation with APIM" "type:daily-target,area:azure" \
"### Objectives
- [ ] Implement \`validate-jwt\` policy
- [ ] Verify claims, issuer, and audience"

create_task "Day 60: APIM Caching & Transformation" "type:daily-target,area:azure" \
"### Objectives
- [ ] Configure response caching policies
- [ ] Transform XML payloads to JSON using Liquid templates"

create_task "Day 61: APIM Developer Portal" "type:daily-target,area:azure" \
"### Objectives
- [ ] Group APIs into Products
- [ ] Enforce subscription keys"

create_task "Day 62: Backend Circuit Breakers in APIM" "type:daily-target,area:azure" \
"### Objectives
- [ ] Configure mock response policies
- [ ] Implement circuit breaker policies for backend resilience"

create_task "Day 63: Week 09 Review & Retrospective" "type:daily-target" \
"### Objectives
- [ ] Consolidate APIM notes in \`docs/notes/week-09.md\`"

# ==========================================
# PHASE 4: SECURITY, OBSERVABILITY & CAPSTONE (Weeks 10-12)
# ==========================================
create_task "Day 64: Azure Key Vault" "type:daily-target,area:azure" \
"### Objectives
- [ ] Create Key Vault and store database credentials
- [ ] Connect .NET Configuration Provider to Key Vault"

create_task "Day 65: Managed Identities" "type:daily-target,area:azure" \
"### Objectives
- [ ] Eliminate credentials in code using \`DefaultAzureCredential\`
- [ ] Assign Azure RBAC roles"

create_task "Day 66: Azure App Configuration" "type:daily-target,area:azure" \
"### Objectives
- [ ] Centralize application settings in App Configuration
- [ ] Implement dynamic feature flags"

create_task "Day 67: Microsoft Entra ID Authentication" "type:daily-target,area:azure" \
"### Objectives
- [ ] Register App Registrations in Microsoft Entra ID
- [ ] Secure Minimal APIs using \`Microsoft.Identity.Web\`"

create_task "Day 68: Role-Based Authorization" "type:daily-target,area:azure" \
"### Objectives
- [ ] Authorize requests by checking token scopes
- [ ] Implement custom authorization policy handlers"

create_task "Day 69: Service-to-Service Authentication" "type:daily-target,area:azure" \
"### Objectives
- [ ] Implement OAuth 2.0 Client Credentials Grant
- [ ] Use MSAL.NET to acquire tokens"

create_task "Day 70: Week 10 Review & Retrospective" "type:daily-target" \
"### Objectives
- [ ] Consolidate Security notes in \`docs/notes/week-10.md\`"

create_task "Day 71: Azure Cache for Redis" "type:daily-target,area:azure" \
"### Objectives
- [ ] Provision Redis instance and connect
- [ ] Implement \`IDistributedCache\` with Cache-Aside pattern"

create_task "Day 72: Redis Pub/Sub" "type:daily-target,area:azure" \
"### Objectives
- [ ] Leverage Redis Sets for high-performance lookups
- [ ] Implement lightweight messaging via Redis Pub/Sub"

create_task "Day 73: Application Insights" "type:daily-target,area:azure" \
"### Objectives
- [ ] Add \`Microsoft.ApplicationInsights.AspNetCore\` SDK
- [ ] Track unhandled exceptions and API response times"

create_task "Day 74: Distributed Tracing" "type:daily-target,area:azure" \
"### Objectives
- [ ] Propagate W3C TraceContext headers
- [ ] Inspect end-to-end transaction maps"

create_task "Day 75: Custom Telemetry & Metrics" "type:daily-target,area:azure" \
"### Objectives
- [ ] Instrument code using \`TelemetryClient\`
- [ ] Export standard .NET Meter metrics"

create_task "Day 76: Kusto Query Language (KQL)" "type:daily-target,area:azure" \
"### Objectives
- [ ] Author KQL queries across requests and exceptions
- [ ] Create Log Analytics alert rules"

create_task "Day 77: Week 11 Review & Retrospective" "type:daily-target" \
"### Objectives
- [ ] Consolidate Observability notes in \`docs/notes/week-11.md\`"

create_task "Day 78: Capstone Architecture Design" "type:daily-target" \
"### Objectives
- [ ] Architect system: Minimal API + Service Bus + Function + Cosmos DB
- [ ] Configure Clean Architecture layers"

create_task "Day 79: Capstone Ingestion API" "type:daily-target" \
"### Objectives
- [ ] Implement secure POST API endpoint
- [ ] Publish messages to Service Bus via Managed Identity"

create_task "Day 80: Capstone Processing Function" "type:daily-target" \
"### Objectives
- [ ] Build Azure Function to process queue items
- [ ] Persist processed records into Cosmos DB"

create_task "Day 81: Capstone Observability" "type:daily-target" \
"### Objectives
- [ ] Add Redis cache for read endpoints
- [ ] Verify complete distributed trace in Application Insights"

create_task "Day 82: Capstone CI/CD" "type:daily-target" \
"### Objectives
- [ ] Automate pipeline via GitHub Actions
- [ ] Deploy API and Function to Azure"

create_task "Day 83: AZ-204 Practice Exam" "type:daily-target" \
"### Objectives
- [ ] Complete Microsoft Learn official AZ-204 practice assessment
- [ ] Review weak areas"

create_task "Day 84: 12-Week Retrospective" "type:daily-target" \
"### Objectives
- [ ] Write final retrospective in \`README.md\`
- [ ] Schedule AZ-204 examination"

echo "=== All Done! Check your GitHub Project Board ==="
