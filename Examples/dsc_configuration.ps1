$ConfigurationData = @{
    AllNodes = @(
      @{
        NodeName                    = 'localhost'
        PSDscAllowPlainTextPassword = $True
      }
    )
}
$pass = (convertto-securestring -asplaintext -force '$piderM@n1')
$cred = (New-Object System.Management.Automation.PSCredential ('Administrator', $pass))

configuration default {
  param (
    $ComputerName = 'localhost'
  )
  Import-DscResource -Module cNuget
  
  node $ComputerName {
    cNuget default {
      PackageSource = "$ENV:SYSTEMDRIVE\Modules"
      Name = 'Modules'
      Port = 81
      APIKey = 'myapikey'
      AllowNugetPackagePush = $true
      AllowPackageOverwrite = $true
    }
    <#cPSRepo default {
      Ensure = 'Present'
      Name = 'Local'
      PublishUri = 'http://localhost/'
      SourceUri = 'http://localhost/nuget'
      InstallPolicy = 'trusted'
      PSDscRunAsCredential = $cred
    }#>
  }
}