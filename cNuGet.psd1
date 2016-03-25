#
# Module manifest for module 'cNuget'
#
# Generated by: Jason
#
# Generated on: 3/20/2016
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'cNuget.psm1'

# Version number of this module.
ModuleVersion = '1.2.6'

# ID used to uniquely identify this module
GUID = 'f8ece87b-543c-4aa1-8082-1de98d06b4a2'

# Author of this module
Author = 'Jason'

# Company or vendor of this module
CompanyName = 'PowerShell.org'

# Copyright statement for this module
Copyright = '(c) 2015 Jason. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Configure a local Nuget repository for PowerShell modules or other packages'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
ProcessorArchitecture = 'None'

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @('cPSRepo.ps1')

# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('tools.psm1')

# Functions to export from this module
FunctionsToExport = @()

# Cmdlets to export from this module
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = @()

# Aliases to export from this module
AliasesToExport = @()

# DSC resources to export from this module
DscResourcesToExport = @('cNuget','cPSRepo','cPackageRepo')

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @(
          'Nuget'
          'PowerShellGet'
          'Package'
          'PackageManager'
          'Module'
          'DSC'
          'PSGallery'
        )

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/PowerShellOrg/cNuGet'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # External dependent modules of this module
        # ExternalModuleDependencies = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

