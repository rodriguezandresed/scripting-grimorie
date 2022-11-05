# 1 Get Current Location 
Get-Location
pwd ################ Alias
gl   ################# Alias

# 2 Preserve current path
Push-Location

# 3 Set current working location to D:
Set-Location -Path D:\PSTraining\PracticeGround

# 4 Retain location, that was preserved using Push-Location
Pop-Location


