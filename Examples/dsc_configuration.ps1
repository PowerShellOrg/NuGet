configuration default {
  param (
    $ComputerName = 'localhost'
  )
  Import-DscResource -Module cNuget
  
  node $ComputerName {
    cNuget default {
      PackageSource = "$ENV:SYSTEMDRIVE\Packages"
      APIKey = 'myapikey'
      AllowNugetPackagePush = $true
      AllowPackageOverwrite = $true
    }
  }
}