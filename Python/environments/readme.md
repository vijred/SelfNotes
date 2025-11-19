How to create a virtual environment - 
`py -m venv mytestenv`

How to use new environment created - 
Linux - `source mytestenv/bin/activate`
Windows - `mytestenv\Scripts\activate.bat`
Windows (Powershell) - `.\myenv\Scripts\Activate.ps1` (If necessary - `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`)

How to exit virtual environment - 
`deactivate`




# Python venv & Package Cheat Sheet

## 🔎 Checking Python & Environments
* Show which Python interpreter is being used:

```powershell
python -c "import sys; print(sys.executable)"
```

* List site-packages path:

```powershell
python -m site
```

* List all versions of Python installed
```
py -0
```

* Show the location of Certificate used by Python - `python -m certifi`; Appent required certificates to this file!


## 📦 Checking Installed Packages

* Show details for a specific package:

```powershell
pip show package_name
```

* Show details using Python's pip (guaranteed correct environment):

```powershell
python -m pip show package_name
```

* List all installed packages:

```powershell
pip list
```

* Filter package list for a specific package:

```powershell
python -m pip list | findstr package_name
```

## 📥 Installing Packages

* Install a package in the current environment:

```powershell
pip install package_name
```

* Safer install matching the Python interpreter:

```powershell
python -m pip install package_name
```

* Install all dependencies from a requirements.txt file:

```powershell
pip install -r requirements.txt
```
```powershell
# To install on a given virtual environment 
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```

## 🧹 Virtual Environments

* Create a virtual environment in folder `.venv`:

```powershell
python -m venv .venv
```

* Activate the virtual environment:

```powershell
.venv\Scripts\activate
```

* Deactivate the virtual environment:

```powershell
deactivate
```

## ⚡ Requirements.txt

* Save current packages & versions:

```powershell
pip freeze > requirements.txt
```

* Re-install all dependencies from the file:

```powershell
pip install -r requirements.txt
```

* This is same in MacOS as well, following commands worked in zsh
```
python3 -m venv .venv
source .venv/bin/activate
pip install -r databricks_app/requirements.txt
```

