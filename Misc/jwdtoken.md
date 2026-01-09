## JWT Token – Quick Reference

A JWT (JSON Web Token) is a compact, URL-safe token used for authentication and authorization between a client and a server. It typically contains a header, payload (claims), and signature.

To view the actual JWT value in a browser:
- Open **Browser → Developer Tools → Network**
- Browse the site or trigger the relevant request
- Look for the request associated with the user/session
- Find the **Authorization** header and copy the JWT value

To decode and troubleshoot a JWT:
- Paste the token into https://jwt.ms/ (Simple Powershell code to the see the details - https://github.com/vijred/SelfNotes/blob/master/Azure/Tools/SecurityTools.md#user-assigned-managed-identities)
- Review the decoded header and claims (issuer, audience, expiry, scopes, etc.) to understand or debug authentication issues
