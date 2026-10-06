# Nexus Commerce 🚀
**Enterprise B2B Order Processing Engine**

## 1. Project Background & Objective
Nexus Commerce is a capstone distributed system designed to bridge the gap between legacy enterprise core banking monoliths built on ASP.NET 4.8 and modern, cloud-native architectures. 

The primary objective of this project is to implement a highly scalable, event-driven B2B wholesale order processing engine. It serves as a practical implementation of Domain-Driven Design (DDD), Clean Architecture, and Zero Trust security, deployed entirely on Microsoft Azure.

---

## 2. Software Requirements Specification (SRS)

### A. Functional Requirements (System Activities)
The application must perform the following core business activities:
* **Order Ingestion & Validation:** Accept bulk B2B purchase orders via a REST API, validate inventory availability, and calculate totals using immutable domain logic.
* **Idempotent Processing:** Safely handle network retries by ensuring duplicate HTTP requests do not result in duplicate orders or charges.
* **Product Catalog Management:** Serve high-throughput, low-latency product catalog queries using a NoSQL data store with session consistency.
* **Asynchronous Fulfillment:** Decouple order acceptance from fulfillment. Orders must be queued and processed sequentially per customer (FIFO).
* **Document Generation:** Automatically generate and securely distribute time-limited download links (SAS) for order invoices in PDF/JSON format.
* **B2B Partner Gateway:** Expose APIs to third-party vendors through a secure gateway enforcing rate limits, quotas, and API key subscriptions.

### B. Non-Functional Requirements (System Attributes)
* **High Availability & Autoscaling:** The Web API must dynamically scale out based on concurrent HTTP requests (scale-to-zero supported) and self-heal failed instances.
* **Zero-Credential Security:** The system must not store any raw database passwords, API keys, or storage credentials in application code or environment variables.
* **Observability:** Every distributed transaction (Client -> API -> Queue -> Worker) must share a unified W3C trace ID and aggregate custom business metrics.
* **Zero-Downtime Deployments:** Updates to the monolith must be deployed to staging slots and swapped into production without dropping active TCP connections.

---

## 3. Technology Stack

| Domain | Technology / Framework | Purpose |
| :--- | :--- | :--- |
| **Language & Core** | C# 12, .NET 8 | Primary language features (Records, Primary Constructors, Pattern Matching). |
| **Web API** | ASP.NET Core Minimal APIs | High-performance HTTP routing, replacing legacy MVC Controllers. |
| **Relational Data** | EF Core 8, Azure SQL | ACID-compliant transactional storage for Orders and Customers. |
| **NoSQL Data** | Azure Cosmos DB | Globally distributed, partition-optimized Product Catalog. |
| **Caching** | Azure Cache for Redis | Distributed Cache-Aside implementation to protect database throughput. |
| **Event Messaging** | Azure Service Bus | Guaranteed message delivery (Queues/Topics) and DLQ management. |
| **Telemetry Stream** | Azure Event Hubs | High-throughput ingestion of frontend clickstream analytics. |
| **Serverless Compute** | Azure Functions (Isolated) | Background task orchestration and durable workflow execution. |
| **Containerization** | Docker, Chiseled Ubuntu | Secure, non-root Linux container packaging. |
| **Cloud Hosting** | Azure Container Apps / App Service | PaaS deployment with KEDA autoscaling and deployment slots. |
| **Security & Auth** | Microsoft Entra ID, Key Vault | OAuth 2.0 JWT validation, RBAC, and Managed Identity secrets injection. |
| **API Gateway** | Azure API Management (APIM) | Rate limiting, request routing, and B2B subscription monetization. |
| **Observability** | Application Insights, OpenTelemetry | Distributed W3C tracing, KQL log querying, and APM dashboarding. |

---

## 4. Architectural Data Flow

1. **Ingestion:** A B2B partner authenticates via Entra ID and calls the Azure APIM Gateway.
2. **Routing:** APIM enforces rate limits, validates the JWT, and forwards the request to the ASP.NET Core Minimal API.
3. **Command Execution:** The API validates the payload, saves the transactional state to Azure SQL via EF Core, and publishes an `OrderCreated` event to an Azure Service Bus Topic.
4. **Decoupled Processing:** The API returns an `HTTP 202 Accepted` to the client immediately.
5. **Fulfillment:** An Azure Function (Isolated Worker) triggers off the Service Bus, generates an invoice document in Azure Blob Storage, and updates the final order status.
6. **Telemetry:** Throughout the lifecycle, OpenTelemetry ships performance metrics and correlation IDs to Application Insights for real-time monitoring.

---

## 5. Development Roadmap (12-Week Sprint Cycle)
* **Sprint 01-03:** Domain-Driven Design, C# 12, Minimal APIs, and EF Core.
* **Sprint 04-06:** Docker Linux Containers, Azure PaaS hosting, and Serverless Workers.
* **Sprint 07-08:** Cosmos DB NoSQL, Blob Storage, and Service Bus Pub/Sub.
* **Sprint 09-10:** API Management Gateway, Entra ID Auth, and Key Vault.
* **Sprint 11-12:** Redis Caching, OpenTelemetry, Load Testing, and CI/CD Automation.