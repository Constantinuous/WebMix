#!powershell
param(
	[ValidateNotNullOrEmpty()]             
    [string] $DeployLogFile = "..\Deploy-Packages.log"
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

	function DeployPackage($sourcePackage, $destinationApp)
	{
		printSubHeader "Deploying $destinationApp"
		# $param = -setParam:name="IIS Web Application Name",value="site name"
		$sourcePackage = resolve-path $sourcePackage
		
		$BuildArgs = @{            
            FilePath = $msdeploy            
            ArgumentList = "-verb:sync -source:package='$sourcePackage' -dest:auto -setParam:name='AppPath',value='$destinationApp'"
			RedirectStandardOutput = $DeployLogFile          
            Wait = $true  
			PassThru = $true          
            WindowStyle = "Hidden"            
        }            
            
        # Start the deployment
		$process = Start-Process @BuildArgs

		if($process.ExitCode -eq 0)
		{
			"No Errors when deploying"
		}
		else
		{
			"Error when deploying, ErrorCode is: "+$process.ExitCode
		}

		. $msdeploy -verb:sync -source:package=$sourcePackage -dest:auto -setParam:name='AppPath',value=$destinationApp
	}

	
	# Imports
	. .\Common.ps1

	# Global Variables 
	$msdeploy = GetMsDeploy

	# Execute main
	main
}



