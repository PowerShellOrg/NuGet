Import-Module $PSScriptRoot\..\..\tools.psm1

enum Ensure {
  Present
  Absent
}

[DSCResource[]]
class cNuget {
  #Declare Properties
  [DscProperty(Key)] 
  [string]$Path
  [DscProperty(Mandatory)]
  [string]$APIKey
  [DscProperty()]
  [Boolean]$AllowNugetPackagePush
  [DscProperty()]
  [Boolean]$AllowPackageOverwrite
  #Define Methods
  #Get Method, gathers data about the system state  
  [hashtable] Get() { 
    $Conf = webconfvar -AllowNugetPackagePush $This.AllowNugetPackagePush -AllowPackageOverwrite $This.AllowPackageOverwrite -PackageSource $This.PackageSource -APIKey $This.APIKey
    $return = @{
      IISInstalled = IIS -Action Test
      ASPInstalled = ASP -Action Test
      WWWRootFiles = Zip -action test
      WebConfig = webconf -Conf $Conf -Action test
	}
    }

    return $return
  } 
  
  #Test Method, tests if the system is in the desired state 
  [bool] Test() { 
    $Conf = webconfvar -AllowNugetPackagePush $AllowNugetPackagePush -AllowPackageOverwrite $AllowPackageOverwrite -PackageSource $PackageSource -APIKey $APIKey
    Write-Verbose 'Working on IIS install'
    if (! (IIS -Action test))
    {
      return $false
    }
    Write-Verbose 'Testing on ASPNet'
    if (! (ASP -Action test))
    {
      return $false
    }
    Write-Verbose 'Testing package directory'
    if (! (pkg -Action test -path $PackageSource))
    {
      return $false
    }
    Write-Verbose 'Checking WWWRoot files'
    if (! (Zip -Action test ))
    {
      return $false
    }
    Write-Verbose 'Checking Web.config'
    if (! (webconf -Action test -Conf $Conf))
    {
      return $false
    }
    return $true
  } 
  
  #Replaces Set-TargetResource 
  [void] Set() { 
    $Conf = webconfvar -AllowNugetPackagePush $this.AllowNugetPackagePush -AllowPackageOverwrite $this.AllowPackageOverwrite -PackageSource $this.PackageSource -APIKey $this.APIKey
    Write-Verbose 'Working on IIS install'
    if (! (IIS -Action test))
    {
      Write-Verbose 'Installing IIS'
      IIS -Action set
    }
    Write-Verbose 'Working on ASPNet'
    if (! (ASP -Action test))
    {
      Write-Verbose 'Installing ASPNet'
      ASP -Action set
    }
    Write-Verbose 'Working on package directory'
    if (! (pkg -Action test -path $PackageSource))
    {
      Write-Verbose 'Creating Package directory'
      pkg -Action set -path $PackageSource
    }
    Write-Verbose 'Checking WWWRoot files'
    if (! (Zip -Action test ))
    {
      Write-Verbose 'Building out wwwroot'
      Zip -Action set
    }
    Write-Verbose 'Checking Web.config'
    if (! (webconf -Action test -Conf $Conf))
    {
      Write-Verbose 'setting web.config'
      webconf -Action set -Conf $Conf
    }
  }
}