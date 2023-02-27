
1. First we install the PowerCLI for VMWare integration:

`Install-Module -Name VMware.PowerCLI`

2. Verify Instalation

`Get-Module -ListAvailable -Name VM*`

We can check all the commands we can use by:

`Get-Command -Module PowerCLI`

3. (Optional) Remove alerts due self-signed certificates

`Set-PowerCLIConfiguration -InvalidCertificateAction:Ignore`

4. Connect to your server

`Connect-VIServer -Server XXX.XXX.XXX.XXX -User YYY -Password ZZZ`

or (and much better)

`Connect-VIServer -Server X -Credential (Get-Credential)

5. List our Datastores

`Get-Datastore`

6. For easier manipulation, we can create a new drive

`New-PSDrive -Name VMWdrive -PSProdiver ViMdatastore -Root '\' -location (Get-Datastore "DatastoreName")`

or set the VM as an object by (even better):

`$MyVM = Get-VM -Name "MyVMToUse"`

Note: if we need to shut it down, we can:

`$MyVM | Stop-VM`

7. We can locate our items by:

`Get-ChildItem -Path 'MyDS:\PathFolder\'

8. Make sure the VM is turned off, we can turn it off by:

`-ShutDown-VMGuest -VM "MyVM"` 

9. Copy our DataStore Item, note that for VMWare Images, the file *-flat.vmdk is the one we're looking for

`Copy-DatastoreItem "MyDS:\CentOS General IT\CentOS General IT-flat.vmdk" -Destination "F:\Tools" -Force`

10. Export the OVF File:

`Export-VApp -VM "My_VM_Template" -Destination 'F:\Destination' -Format OVA

`$MyVM | Export-VApp -Destination 'F:\Tools' -Format OVA 

We can add the parameter `-RunAsync` to run it as a job

11. To import the VM we can 

`Import-VApp -Source 'C:\LocationOfTemplate\My_VM_Template.ovf' -Datestore $myDatastore -Force`