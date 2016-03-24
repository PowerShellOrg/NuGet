enum ensures {
  Present
  Absent
}

enum policies {
  Trusted
  Untrusted
}

[DSCResource()]
class cPSRepo {
  #Declare Properties
  [DscProperty(Key)] 
  [ensures]$Ensure
  [DscProperty(Mandatory)]
  [string]$ProviderName
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
    if (! (provider -Name $this.ProviderName -Action test )) {
      return $false
    }
    return $true
  } 
  
  #Replaces Set-TargetResource 
  [void] Set () { 
    if (! (provider -Name $this.ProviderName -Action test )) {
      Write-Verbose 'creating new provider'
      provider -Name $this.ProviderName -Action set -PublisherURI $this.PublishURI -SourceURI $this.SourceURI -Type $this.InstallPolicy
    }
  }
}