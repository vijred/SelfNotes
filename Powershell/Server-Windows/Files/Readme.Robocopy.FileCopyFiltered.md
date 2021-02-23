Copy filtered files form one location to other using robocopy
=============================================================


```
# Script to Sync non-PayX content to different Folder 
$sourceFolder = "C:\SourceLocation\SelfNotes\"
$DestinationFolder =  "C:\destination\SelfNotes\"
$ExcludeStringCriteria = "msft"

$AllFiles = get-childitem $sourceFolder -R | Where-Object {$_.FullName -notmatch $ExcludeStringCriteria} 

foreach($obj in $AllFiles)
{
	if ($obj.Attributes -eq "Directory"){
		robocopy $obj.FullName ($obj.FullName).Replace($sourceFolder,$DestinationFolder) /XO /xx /xf *
	}
	else{
		robocopy $obj.Directory.FullName ($obj.Directory.FullName).Replace($sourceFolder,$DestinationFolder) $obj.Name -XO 
	}
}
```


