describe "Testing the default configuration of cBitsServer" {
    context "Bits website | napmSources | W3SVC" {
        it "ensures IIS installed" {
            (get-windowsfeature -name web-server).installed | should be $true
        }
        it "checks for bits website" {
            get-website -name "Bits" | should not be $null
        }
        it "ensures bits directory exists" {
            test-path $env:SYSTEMDRIVE\Bits -type container | should be true
        }
        it "ensures w3svc is running" {
            (get-service -name w3svc).status | should match 'running'
        }
    }
}
