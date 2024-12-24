

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
  * Make sure to enable Web terminal from settings -> Compute; Need to run from a personal compute with spark vesion 15.1 or more.
  * Sample command to test - `databricks current-user me`
* Databricks resources can be managed and viewed using CLI, CLI needs to be installed for the same. Ref: https://docs.databricks.com/dev-tools/cli/index.html
  * Once the profile is configured, the detals will be stored in a hidden file. You can see the profile infomration using the powershell command - Get-Content ~/.databrickscfg

* Tell me about Databricks CLI
  * Databricks Command-Line Interface is easy to use from Terminal  command prompt.
  * Databricks CLI needs to be installed on system and configured for given workspace
  * cli installation and configuration instructions can be found @ https://learn.microsoft.com/en-us/azure/databricks/dev-tools/cli/
  * How to view commands (help) - `databricks configure --help` or `databricks --help`
  * Default location of configuration file in windows - `%USERPROFILE%\.databrickscfg` (`~/.databrickscfg` in linux)
  * Sample command to give Scope Read access to a Databricks Group
  ```
  databricks groups list
  databricks secrets list-scopes
  databricks secrets put-acl --scope myScopeName --principal MyDatabricksGroupName --permission READ
  ```
