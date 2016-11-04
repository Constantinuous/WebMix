#!powershell
[CmdletBinding()]
param(
	[ValidateNotNullOrEmpty()]             
    [string] $DeployLogFile = "..\Deploy-Packages.log",

	[ValidateNotNullOrEmpty()]             
    [string] $DeployErrorLogFile = "..\Deploy-Packages-Error.log"
);

          
process            
{
	function main
	{
		EnforcePreConditions
		DeployPackages
	}

	function EnforcePreConditions
	{
		EnforceIsAdministrator

		printHeader "MsDeploy"
	
		EnforceExeExists $msdeploy -missingMessage "Please install ms deploy"

	}

	function DeployPackages
	{
		printHeader "Deploying Packages"

		DeployPackage -sourcePackage "..\WebDeploy\AspMix.zip" -destinationApp "WebMix"
		DeployPackage -sourcePackage "..\WebDeploy\SubMix.zip" -destinationApp "WebMix/SubMix"
	}

	function GetParameters($sourcePackage)
	{
		$output = & $msdeploy -verb:getparameters -source:package=$source
	}

	function DeployPackage($sourcePackage, $destinationApp)
	{
		printSubHeader "Deploying $destinationApp"
		# $param = -setParam:name="IIS Web Application Name",value="site name"
		$sourcePackage = resolve-path $sourcePackage
		$setParameters = resolve-path "SetParameters.xml"

		"Parameter File is at: $setParameters"
   
            
		 $output = & $msdeploy -verb:sync -source:package=$source -dest:auto -setParamFile:"$SetParams" -enableRule:DoNotDeleteRule *>>$DeployLogFile
		
		Get-Content $DeployLogFile | select -Last 3
		if($LASTEXITCODE -eq 0)
		{
			"  [OK]  "
		}
		else
		{
			"  [FAIL] with Error Code: "+$LASTEXITCODE
		}
	}

	
	# Imports
	. .\Common.ps1

	# Global Variables 
	$msdeploy = GetMsDeploy

	# Execute main
	main
}



