Basic Windows commands
=========================

* How to add a folder to PATH environment variable at user level - `[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Users\mypath\bin", "User")`
* Event viewer search; this example is to find SHIR (Integration runtime) relateditems.
```
PS C:\Users\vkundana_alt> Get-WinEvent -LogName "Connectors – Integration Runtime" |
>> Where-Object {
>>     $_.TimeCreated -ge $Start -and
>>     $_.TimeCreated -le $End -and
>>     $_.Message -match "myserach sername"
>> }

```
* 
