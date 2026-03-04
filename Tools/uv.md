# Modern Python Package Management with UV

## What is UV?

**UV** is a modern, extremely fast Python package and project manager written in Rust. It's designed to replace `pip`, `pip-tools`, `pipx`, `poetry`, `pyenv`, and `virtualenv` with a single tool.

### Key Advantages over pip:
- **10-100x faster** than pip
- Built-in virtual environment management
- Handles dependency resolution better
- Single binary, no Python required to install
- Cross-platform (Windows, macOS, Linux)

---

## Installation Methods

### Method 1: Standalone Installer (Recommended)

**Windows (PowerShell):**
```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

**MACIS/Linux**
```
curl -LsSf https://astral.sh/uv/install.sh | sh
```

This installs uv to:

* Windows: C:\Users\<username>\.local\bin
* macOS/Linux: ~/.local/bin

using PIP, how to install UO
```
# Using Python launcher (Windows)
py -m pip install uv

# Using python directly
python -m pip install uv
```

* Adding uv to path - Windows: `[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Users\<username>\.local\bin", "User")`
* Adding uv to path - Linux: `export PATH="$$HOME/.local/bin:$$PATH"`

* Workaround to add User Path variables to vscode -
```
# Open Profile in notepad
notepad $PROFILE

# Ensure both User and System PATH are loaded
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")

# Save and load
. $PROFILE
```


## Using UV - Quick Start
* Install a package: - `uv pip install <package-name>`
* Install from requirements.txt: `Install from requirements.txt:`
* Create Virtual Environment: `uv venv`
* 

Activate virtual environment:

```
# Windows
.venv\Scripts\activate

# macOS/Linux
source .venv/bin/activate
Add package to project (with pyproject.toml):
```

uv add <package-name>
```
Install from custom index:
```
uv pip install --index-url https://custom-repo.com/simple <package-name>
```

Working with Private Repositories
Configure in pyproject.toml:

toml
```
[[tool.uv.index]]
name = "private-repo"
url = "https://your-private-repo.com/simple"
default = true
```
Then install:

```
uv add --native-tls <package-name>
```
Note: --native-tls uses system's native TLS/SSL, useful for corporate networks.

```

