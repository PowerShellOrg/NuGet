configuration default {
  param (
    $ComputerName = 'localhost'
  )
  Import-DscResource cNuget
  
  node $ComputerName {
    cNuget default {
      Path = "$ENV:SYSTEMDRIVE\Packages"
      APIKey = 'myapikey'
      AllowNugetPackagePush = $true
      AllowPackageOverwrite = $true
    }
  }
}