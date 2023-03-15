1. Identify the SSCI controller type:

`less *.vmx | grep -i virtualdev`

2. Get the size of the flat file:

`ls -l filenime-flat.vmdk`

3. create temp vmdk files:

`vmkfstools -c filesize -a $scsi_type -d thin temp.vmdk`

4. Rename the temp.vmdk file to match the orphaned flat.vmdk file:

`mv -i temp.vmdk $namefile.vmdk`

5. edit the .vmdk file to point to the real flat-file

`vi temp.vmdk`

shift r -> replace mode

esc -> exit remplace mode 

shift zz to save file

Under of the #Extent description line, edit the temp-flat.vmdk to the real name

6. delete temp files:

`rm -i temp-flat.vmdk`