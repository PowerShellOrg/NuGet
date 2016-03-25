$ConfigurationData = @{
    AllNodes = @(
      @{
        NodeName                    = 'localhost'
        PSDscAllowPlainTextPassword = $True
      }
    )
}
$pass = (convertto-securestring -asplaintext -force 'vagrant')
$cred = (New-Object System.Management.Automation.PSCredential ('vagrant', $pass))

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
    cPSRepo default {
      Ensure = 'Present'
      Name = 'Modules'
      PublishUri = 'http://localhost:81/'
      SourceUri = 'http://localhost:81/nuget'
      InstallPolicy = 'trusted'
      PSDscRunAsCredential = $cred
    }#>
    cPSRepo PSGallery {
      Ensure = 'Absent'
      Name = 'PSGallery'
      PSDscRunAsCredential = $cred
    }#>
    cNuget packages {
      PackageSource = "$ENV:SYSTEMDRIVE\Packages"
      Name = 'Packages'
      Port = 82
      APIKey = 'myapikey'
      AllowNugetPackagePush = $true
      AllowPackageOverwrite = $true
    }
    cPackageRepo default {
      Ensure = 'Present'
      Name = 'Packages'
      ProviderName = 'Nuget'
      SourceUri = 'http://localhost:82'
      InstallPolicy = 'Trusted'
      PSDscRunAsCredential = $cred
    }
  }
}