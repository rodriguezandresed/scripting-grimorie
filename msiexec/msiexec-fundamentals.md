The msiexec is used to install apps from .exe or .msi files

/i specifies location of where to install

/qn specifies silent mode, you can also use /quiet

/log specifies the location for the log file, it can be used along with wildcards like %MACHINENAME% 

/f specifies that you want to repair an app that is already installed

You can use aditional atributes like REBOOT=NO or /norestart
