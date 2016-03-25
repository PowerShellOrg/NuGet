describe "Testing the default configuration of cNuget" {
    context "Nuget website | napmSources | W3SVC" {
        it "ensures IIS installed" {
            (get-windowsfeature -name web-server).installed | should be $true
        }
        it "checks for nuget website" {
            get-website -name "*" | should not be $null
        }
        it "ensures bits directory exists" {
            test-path $env:SYSTEMDRIVE\Packages -type container | should be true
        }
        it "ensures w3svc is running" {
            (get-service -name w3svc).status | should match 'running'
        }
    }
}
