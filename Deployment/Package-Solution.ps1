#!powershell
param(
	[string]$publishProfile = "Package",
	[string]$solution = "..\AspMix.sln",
	[string]$vsToolVersion = "VisualStudioVersion=14.0"
);

          
process            
{
	function main
	{
		EnforcePreConditions
		CreatePackages
	}

	function EnforcePreConditions
	{
		EnforceIsAdministrator

		printHeader "MsBuild"
	
		EnforceExeExists $msBuild -missingMessage "Please install msbuild"
		EnforceExeExists "nuget" -missingMessage "- Please install nuget via: choco install nuget.commandline"

		. $msbuild /version
		""
	}

	function CreatePackages
	{
		printHeader "Create Packages"

		$publishArgument = "/p:DeployOnBuild=true;PublishProfile=$publishProfile;$vsToolVersion "
		$OutputVariable = & $msBuild $solution $publishArgument
		$obj = New-Object PSObject
   
		if($LastExitCode -eq 0)
		{
			"No Errors when packaging"
		}
		else
		{
			"Error when packaging"
		}
	}
	

	. .\Common.ps1
	$msBuild = GetMsBuild
	main
}

