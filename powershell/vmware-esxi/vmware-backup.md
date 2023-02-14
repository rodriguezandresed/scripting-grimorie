
1. First we install the PowerCLI for VMWare integration:

`Install-Module -Name VMware.PowerCLI`

2. Verify Instalation

`Get-Module -ListAvailable -Name VM*`

3. (Optional) Remove alerts due self-signed certificates

`Set-PowerCLIConfiguration -InvalidCertificateAction:Ignore`

4. Connect to your server

`Connect-VIServer -Server XXX.XXX.XXX.XXX -User YYY -Password ZZZ

5. List our Datastores

`Get-Datastore`

5. For easier manipulation, we can create a new drive

`New-PSDrive -Name VMWdrive -PSProdiver ViMdatastore -Root '\' -location (Get-Datastore "DatastoreName")`

6. We can locate our items by:

`Get-ChildItem -Path 'MyDS:\PathFolder\'

7. Copy our DataStore Item, note that for VMWare Images, the file *-flat.vmdk is the one we're looking for

`Copy-DatastoreItem "MyDS:\CentOS General IT\CentOS General IT-flat.vmdk" -Destination "F:\Tools" -Force`