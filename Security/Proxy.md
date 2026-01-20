# Using HTTPS Proxy via Environment Variables

**Proxy (high-level):** A network intermediary that routes, filters, and audits outbound traffic between clients and external services.

** Command to test proxy settings (Powershell - `netsh winhttp show proxy`

## Windows (PowerShell)

```powershell
$env:HTTPS_PROXY = "http://proxydatacentername-server.mydomain.com:80"
$env:HTTP_PROXY  = "http://proxydatacentername-server.mydomain.com:80"
$env:NO_PROXY    = "localhost,127.0.0.1,.mydomain.com"
```

### Notes
- Applies only to the current PowerShell session.
- Most SDKs and tools (Python, curl, Node.js, .NET, Azure SDKs) automatically honor these variables.

---

## Linux / macOS (Bash, Zsh, etc.)

```bash
export HTTPS_PROXY="http://proxydatacentername-server.mydomain.com:80"
export HTTP_PROXY="http://proxydatacentername-server.mydomain.com:80"
export NO_PROXY="localhost,127.0.0.1,.mydomain.com"

# Option to use proxy while using curl command without environment variable.
curl --proxy http://proxydatacentername-server.mydomain.com:80 https://api.externalvendor.com
```



### Notes
- Applies to the current shell session.
- To make persistent, add the `export` lines to `~/.bashrc`, `~/.zshrc`, or `/etc/environment` (system-wide).

---

## When to Use
- Corporate networks with restricted outbound internet
- Cloud services with controlled egress (Azure App Service, Databricks, VMs)
- Environments requiring auditing, logging, or security inspection

## Common Tools That Honor These Variables
- Python (`requests`, `pip`)
- curl, wget
- Node.js (Axios, npm)
- .NET HttpClient
- Azure, AWS, GCP SDKs
