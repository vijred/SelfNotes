# Grant an Azure App Registration Access to a Specific SharePoint Online Site

## Objective

Grant an Azure App Registration access to a specific SharePoint Online site using the Microsoft Graph `Sites.Selected` permission model.

This approach follows the principle of least privilege by restricting the application to only the required SharePoint site instead of granting tenant-wide access.

---

## Prerequisites

The Azure App Registration must have the following Microsoft Graph Application Permission:

```text
Sites.Selected
```

Admin consent must be granted for the permission.

---

## Option 1 - PnP PowerShell

Connect to the target SharePoint site:

```powershell
Connect-PnPOnline `
    -Url "https://<tenant>.sharepoint.com/sites/<site-name>" `
    -Interactive
```

Grant site access to the App Registration:

```powershell
Grant-PnPAzureADAppSitePermission `
    -AppId "<application-client-id>" `
    -DisplayName "<application-name>" `
    -Site "https://<tenant>.sharepoint.com/sites/<site-name>" `
    -Permissions Read
```

Possible permission levels:

```text
Read
Write
FullControl
```

Verify the assignment:

```powershell
Get-PnPAzureADAppSitePermission `
    -Site "https://<tenant>.sharepoint.com/sites/<site-name>"
```

---

## Option 2 - Microsoft Graph

Retrieve the Site ID:

```http
GET https://graph.microsoft.com/v1.0/sites/<tenant>.sharepoint.com:/sites/<site-name>
```

Grant the permission:

```http
POST https://graph.microsoft.com/v1.0/sites/{site-id}/permissions
```

Request Body:

```json
{
  "roles": [
    "read"
  ],
  "grantedToIdentities": [
    {
      "application": {
        "id": "<application-client-id>",
        "displayName": "<application-name>"
      }
    }
  ]
}
```

This grants the application access only to the specified site.

---

## Validation

After the permission is granted:

1. Obtain an OAuth token using the Client Credentials flow.
2. Access SharePoint content through Microsoft Graph or SharePoint APIs.
3. Confirm that the application can access only the assigned site and no other sites.

---

## Common Issues

### AADSTS50105

```text
Application is configured to block users unless specifically assigned access.
```

This indicates the user attempting to run Microsoft Graph PowerShell or another client application has not been assigned access to the Enterprise Application. An Entra ID administrator must assign the user or a group to the application before authentication can succeed.

### Sites.Selected Permission Assigned but Access Still Fails

Having the following permission alone:

```text
Sites.Selected
```

does not grant access to any SharePoint site.

A separate site-level permission assignment must be performed using either PnP PowerShell or Microsoft Graph.

---

## Information Required by the Administrator

Provide the administrator with:

```text
SharePoint Site URL:
https://<tenant>.sharepoint.com/sites/<site-name>

Application Name:
<application-name>

Application (Client) ID:
<application-client-id>

Requested Permission:
Read | Write | FullControl
```
