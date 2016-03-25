enum ensures {
  Present
  Absent
}

enum policies {
  Trusted
  Untrusted
}

Import-Module $PSScriptRoot\tools.psm1

[DSCResource()]
class cPackageRepo {
  #Declare Properties
  [DscProperty(Key)] 
  [ensures]$Ensure
  [DscProperty(Mandatory)]
  [string]$Name
  [DscProperty(Mandatory)]
  [string]$ProviderName
  [DscProperty(Mandatory)]
  [string]$SourceUri
  [DscProperty(Mandatory)]
  [policies]$InstallPolicy
  #Define Methods
  #Get Method, gathers data about the system state  
  [cPackageRepo] Get () { 
    return $this
  } 
  
  #Test Method, tests if the system is in the desired state 
  [bool] Test () { 
    Import-Module $PSScriptRoot\tools.psm1
    return (package_provider -Name $this.Name -Action test -Ensure $this.Ensure)
  } 
  
  #Replaces Set-TargetResource 
  [void] Set () { 
    Import-Module $PSScriptRoot\tools.psm1
    Write-Verbose 'creating new provider'
    package_provider -Name $this.Name -Action set -SourceURI $this.SourceURI -Credential $this.Credential -Ensure $this.Ensure
  }
}

[DSCResource()]
class cPSRepo {
  #Declare Properties
  [DscProperty(Key)] 
  [ensures]$Ensure
  [DscProperty(Mandatory)]
  [string]$Name
  [DscProperty(Mandatory)]
  [string]$PublishUri
  [DscProperty(Mandatory)]
  [string]$SourceUri
  [DscProperty(Mandatory)]
  [policies]$InstallPolicy
  #Define Methods
  #Get Method, gathers data about the system state  
  [cPSRepo] Get () { 
    return $this
  } 
  
  #Test Method, tests if the system is in the desired state 
  [bool] Test () { 
    Import-Module $PSScriptRoot\tools.psm1
    return (provider -Name $this.Name -Action test -Ensure $this.Ensure)
  } 
  
  #Replaces Set-TargetResource 
  [void] Set () { 
    Import-Module $PSScriptRoot\tools.psm1
    Write-Verbose 'creating new provider'
    provider -Name $this.Name -Action set -PublisherURI $this.PublishURI -SourceURI $this.SourceURI -Type $this.InstallPolicy -Credential $this.Credential -Ensure $this.Ensure
  }
}

[DSCResource()]
class cNuget {
  #Declare Properties
  [DscProperty(Key)] 
  [string]$PackageSource
  [DscProperty(Mandatory)]
  [string]$APIKey
  [DscProperty()]
  [Boolean]$AllowNugetPackagePush
  [DscProperty()]
  [Boolean]$AllowPackageOverwrite
  #Define Methods
  #Get Method, gathers data about the system state  
  [cNuget] Get () { 
    return $this
  } 
  
  #Test Method, tests if the system is in the desired state 
  [bool] Test () { 
    Import-Module $PSScriptRoot\tools.psm1
    $Conf = webconfvar -AllowNugetPackagePush $This.AllowNugetPackagePush -AllowPackageOverwrite $This.AllowPackageOverwrite -PackageSource $This.PackageSource -APIKey $This.APIKey
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
    if (! (pkg -Action test -path $This.PackageSource))
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
  [void] Set () { 
    Import-Module $PSScriptRoot\tools.psm1
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
    if (! (pkg -Action test -path $This.PackageSource))
    {
      Write-Verbose 'Creating Package directory'
      pkg -Action set -path $This.PackageSource
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