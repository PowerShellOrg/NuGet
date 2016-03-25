<#enum ensures {
  Present
  Absent
}

enum policies {
  Trusted
  Untrusted
}


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
#>