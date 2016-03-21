configuration default {
  param (
    $ComputerName = 'localhost'
  )
  Import-DscResource -Module cNuget
  
  node $ComputerName {
    cNuget default {
      Path = "$ENV:SYSTEMDRIVE\Packages"
      APIKey = 'myapikey'
      AllowNugetPackagePush = $true
      AllowPackageOverwrite = $true
    }
  }
}
default
Start-DscConfiguration -Path default -Force -Wait -Verbose