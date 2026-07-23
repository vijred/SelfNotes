# Azure Data Factory Linked Services – Using Certificates from Azure Key Vault

## Overview

When configuring certificate-based authentication in Azure Data Factory (ADF) Linked Services, there is an important difference between:

1. Uploading a certificate directly into the Linked Service
2. Storing a certificate in Azure Key Vault and referencing it from the Linked Service

This document captures the key learning and required steps.

---

## Key Difference

### Scenario 1: Upload Certificate Directly to ADF Linked Service

If the Linked Service allows direct certificate upload:

- Upload the `.pfx` certificate file directly.
- No Base64 conversion is required.
- Authentication works as expected.

✅ Works with the original `.pfx` file.

---

### Scenario 2: Store Certificate in Azure Key Vault and Reference from ADF

When the certificate is stored in Azure Key Vault and referenced by an ADF Linked Service:

- Uploading the raw `.pfx` file to Key Vault is not sufficient.
- The certificate content must first be converted to a Base64-encoded string.
- The Base64 value is then stored as a Key Vault Secret.
- ADF reads the secret value and reconstructs the certificate during authentication.

✅ Works when the certificate is stored as a Base64-encoded secret.
❌ May fail when the certificate is simply uploaded and referenced without proper encoding.

---

## Recommended Approach

1. Obtain the `.pfx` certificate file.
2. Convert the certificate to a Base64 string.
3. Store the Base64 string in Azure Key Vault as a Secret.
4. Configure the ADF Linked Service to reference the Key Vault Secret.
5. Provide the certificate password separately if required by the target service.

---

## PowerShell – Convert PFX to Base64

### Read the certificate file

```powershell
$pfxBytes = Get-Content "C:\Certificates\MyCertificate.pfx" -Encoding Byte
```

### Convert to Base64

```powershell
$base64Certificate = [System.Convert]::ToBase64String($pfxBytes)
```

### Display the Base64 value

```powershell
$base64Certificate
```

### Save the Base64 value to a text file

```powershell
$base64Certificate | Out-File `
    -FilePath "C:\Certificates\MyCertificate_Base64.txt" `
    -Encoding ascii
```

---

## Complete Example

```powershell
# Path to PFX certificate
$pfxPath = "C:\Certificates\MyCertificate.pfx"

# Read certificate bytes
$pfxBytes = Get-Content $pfxPath -Encoding Byte

# Convert to Base64
$base64Certificate = [System.Convert]::ToBase64String($pfxBytes)

# Save Base64 string to file
$base64Certificate | Out-File `
    -FilePath "C:\Certificates\MyCertificate_Base64.txt" `
    -Encoding ascii

Write-Host "Certificate successfully converted to Base64."
```

---

## Upload Base64 Value to Azure Key Vault

### Using Azure PowerShell

```powershell
$secretValue = Get-Content "C:\Certificates\MyCertificate_Base64.txt" -Raw

$secureSecret = ConvertTo-SecureString `
    $secretValue `
    -AsPlainText `
    -Force

Set-AzKeyVaultSecret `
    -VaultName "<KeyVaultName>" `
    -Name "<SecretName>" `
    -SecretValue $secureSecret
```

---

## Validation Checklist

Before testing the ADF Linked Service:

- [ ] Certificate is valid and not expired.
- [ ] Certificate has been converted to Base64.
- [ ] Base64 value is stored as a Key Vault Secret.
- [ ] ADF Managed Identity has permission to read Key Vault Secrets.
- [ ] Correct secret name is referenced in the Linked Service.
- [ ] Certificate password is supplied where required.
- [ ] Linked Service connection test succeeds.

---

## Lessons Learned

The requirement to convert the certificate to Base64 applies specifically when Azure Data Factory retrieves the certificate from Azure Key Vault as a Secret.

| Storage Method | Base64 Conversion Required |
|---------------|----------------------------|
| Direct upload of `.pfx` into Linked Service | No |
| `.pfx` stored in Key Vault and referenced by ADF | Yes |

**Rule of Thumb:** If ADF reads the certificate from Key Vault as a Secret, store the certificate as a Base64-encoded value. If the certificate is uploaded directly into the Linked Service, use the original `.pfx` file.
