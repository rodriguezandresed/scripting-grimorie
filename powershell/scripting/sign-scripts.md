To make our environment use signed keys: `Set-Executionpolicy Allsigned -force`

We can create a self-signed certificate by:

`New-SelfSignedCertificate -type CodeSigningCert -Subject "CN=ArtDeco" -CertStoreLocation Cert:\CurrentUser\My\ -testroot`

If we are self-signing certificates, the CN should be our name.

To trust our own certificates (On Windows Machines), we need to put them in the `Trusted Root Certification Authority` category.

To sign our scripts we can follow these steps:

Assuming the following script:

```bash
get-content psvm.ps1
get-process | sort vm -desc | select -first 5
```

1. Save the path to the certificate:

` $cert = dir Cert:\CurrentUser\My\ -CodeSigningCert`

2. (OPTIONAL) Create an alias for the Set-AuthenticodeSignature cmdlet:

`Set-Alias -Name sign -Value Set-AuthenticodeSignature`

3. Sign your script:

`sign  .\psvm.ps1 -Certificate $cert`

Note: to unsign a file, we can delete the certificate block in the script.

4. (OPTIONAL) Sign a directory of scripts:

`dir *.ps1 | sign -Certificate $cert -WhatIf`

5. Test the signature

`Get-AuthenticodeSignature .\psvm.ps1`

We can further check using: `Get-AuthenticodeSignature .\psvm.ps1 | select *`

If the signature wasn't trusted, we would get unknown error status.