<#enum ensures {
  Present
  Absent
}

enum policies {
  Trusted
  Untrusted
}

Import-Module $PSScriptRoot\tools.psm1

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
}#>