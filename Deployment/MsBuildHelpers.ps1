function InstallSolutionPackages($solution)
{ 
	Write-Host $solution
	& nuget restore $solution | Out-Null
}