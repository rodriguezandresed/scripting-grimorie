We can use the pipeline and | format-table -auto to format the output to a better view.

For example, when we have a YAML file we can read the content using:

`Get-Content -Raw file`

Or format the output into a table using:

`Get-Content -Raw file | ConvertFrom-Yaml`

And see the kind of objects:

`Get-COntent -Raw file | ConvertFrom-Yaml | gm`

If we wanted to convert the output to json:

`Get-Content -Raw file | ConvertFrom-Yaml | ConvertTo-Json -Depth 100`

----------------------------

Reminder:

When troubleshooting trying to find commands we could:

`Get-Help *name*`

`Get-Command -noun *name*`

`Find-Module *name* | format table -auto`

`Find-Module -tag Name`

(installing from repository)

`Install-Module modulename -Repository PSGallery`