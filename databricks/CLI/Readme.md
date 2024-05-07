

Databricks CLI 
==============

* Reference to install Databricks CLI - https://docs.databricks.com/en/dev-tools/cli/install.html#cli-workspace
```
winget search databricks
winget install Databricks.DatabricksCLI
```

* Check version - `databricks -v`
* List os secret scopes - `databricks secrets list-scopes`
* Databricks CLI Commands - `https://docs.databricks.com/en/dev-tools/cli/commands.html`
* How to creat a scope for a different workspace, example to create a scope for workspace - `databricks configure --profile n46k`
  * Note: When you want ot use the token, Username will be `token` and the Password will be the value of token
*  Default location where the profiles will be stored - `Get-Content ~/.databrickscfg`
*  Example to get the list of secter scopes configured on a profile with n46k `databricks secrets list-scopes --profile n46k`
* How to run CLI from a workspace - Ref: https://docs.databricks.com/en/dev-tools/cli/install.html 
