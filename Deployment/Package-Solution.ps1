#!powershell
[CmdletBinding()]
param(
	[string]$publishProfile = "Package",
	[string]$solution = "..\AspMix.sln",
	[string]$vsToolVersion = "VisualStudioVersion=14.0",
	[ValidateNotNullOrEmpty()]             
    [string] $BuildLogFile = "..\Package-Solution.log",
	[ValidateNotNullOrEmpty()]             
    [string] $BuildErrorLogFile = "..\Package-Solution-Error.log"
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

		$BuildArgs = @{            
            FilePath = $msBuild            
            ArgumentList = $solution, $publishArgument, "/v:minimal"            
            RedirectStandardOutput = $BuildLogFile    
			RedirectStandardError = $BuildErrorLogFile           
            Wait = $true  
			PassThru = $true          
            WindowStyle = "Hidden"            
        }            
            
        # Start the build            
        $process = Start-Process @BuildArgs
   
		if($process.ExitCode -eq 0)
		{
			"No Errors when packaging"
		}
		else
		{
			"Error when packaging, ErrorCode is: "+$process.ExitCode
		}
	}
	
	# Imports
	. .\Common.ps1

	# Global Variables 
	$msBuild = GetMsBuild

	# Execute Main
	main
}

