. .\Common.ps1

function main
{
	EnsureIsAdministrator

	printHeader "MsBuild"
	$msBuild = GetMsBuild

	EnsureExeExists $msBuild -missingMessage "Please install msbuild"
	EnsureExeExists "nuget" -missingMessage "- Please install nuget via: choco install nuget.commandline"

	. $msbuild /version
	""
	printHeader "Start"
}

main