function EnforceIsAdministrator  
{
	if(!(IsAdministrator))
	{
		"Please run this script as admin if you want to publish"
		exit 1
	}else{
		"You are an administator"
	}
}

function IsAdministrator  
{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    return (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function EnforceExeExists($exe, $missingMessage)
{
	if ((Get-Command $exe -ErrorAction SilentlyContinue) -eq $null) 
	{ 
		Write-Host "Exiting, unable to find $exe in your PATH"
		Write-Host $missingMessage
		exit 1
	}
}

function GetMsDeploy
{
	$msdeploy = "C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe"
	return $msdeploy
}

function GetMsBuild
{
	$msBuild = "C:\Program Files` (x86)\MSBuild\14.0\Bin\MSBuild.exe"
	return $msBuild
}

function printHeader($headerName)
{
	"============================================================================"
	"   $headername   "
	"============================================================================"
}

function printSubHeader($headerName)
{
	"----------------------------------------------------------------------------"
	"   $headername   "
	"----------------------------------------------------------------------------"
}