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

	function DeployPackage($sourcePackage, $destinationApp)
	{
		printSubHeader "Deploying $destinationApp"
		# $param = -setParam:name="IIS Web Application Name",value="site name"
		$sourcePackage = resolve-path $sourcePackage
		$setParameters = resolve-path "SetParameters.xml"

		$parameters = "DatabaseUsername='Foobar','CoolValue'='VeryHot'"

		$arguments = @"
			-verb:sync 
			-source:package='$sourcePackage' 
			-dest:auto 
			-allowUntrusted:true
			-enableRule:DoNotDeleteRule
"@
		#     -setParamFile:"package.SetParameters.xml"
		
		$BuildArgs = @{            
            FilePath = $msdeploy            
            ArgumentList = $arguments
			RedirectStandardOutput = $DeployLogFile       
			RedirectStandardError = $DeployErrorLogFile   
            Wait = $true  
			PassThru = $true          
            WindowStyle = "Hidden"            
        }            
            
        # Start the deployment
		$process = Start-Process @BuildArgs

		if($process.ExitCode -eq 0)
		{
			Get-Content $DeployLogFile | select -Last 3
			"  [OK]  "
		}
		else
		{
			Get-Content $DeployErrorLogFile | select -Last 3
			"  [FAIL] with Error Code: "+$process.ExitCode
		}

		#. $msdeploy -verb:sync -source:package=$sourcePackage -dest:auto -setParam:name='AppPath',value=$destinationApp
	}

	
	# Imports
	. .\Common.ps1

	# Global Variables 
	$msdeploy = GetMsDeploy

	# Execute main
	main
}



