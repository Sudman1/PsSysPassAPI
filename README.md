# PsSysPassAPI
Powershell wrapper for the [sysPass ReST API](https://syspass-doc.readthedocs.io/en/3.1/application/api.html)

## Installation

Install from the PowerShell Gallery

## Usage

1. Use `Connect-SysPass` to provide your SysPass server address, API token, and password
2. Use the `Find-*`, `Get-*`, `Set-*`, `New-*`, and `Remove-*` commands associated with the API endpoints as shown in the [API Coverage Section](#api-coverage) below.

## API Coverage

| Endpoint         | Cmdlet                      | Status |
|:-----------------|:----------------------------|:------:|
| account/search   | `Find-SysPassAccount`         | ✅ |
| account/view     | `Get-SysPassAccount`          |   |
| account/viewPass | `Get-SysPassAccountPassword`  | ✅ |
| account/editPass | `Set-SysPassAccountPassword`  |   |
| account/create   | `New-SysPassAccount`          |   |
| account/edit     | `Set-SysPassAccount`          |   |
| account/delete   | `Remove-SysPassAccount`       |   |
| category/search  | `Find-SysPassCategory`        | ✅ |
| category/view    | `Get-SysPassCategory`         |   |
| category/create  | `New-SysPassCategory`         |   |
| category/edit    | `Set-SysPassCategory`         |   |
| category/delete  | `Remove-SysPassCategory`      |   |
| client/search    | `Find-SysPassClient`          | ✅ |
| client/view      | `Get-SysPassClient`           |   |
| client/create    | `New-SysPassClient`           |   |
| client/edit      | `Set-SysPassClient`           |   |
| client/delete    | `Remove-SysPassClient`        |   |
| tag/search       | `Find-SysPassTag`             | ✅ |
| tag/view         | `Get-SysPassTag`              |   |
| tag/create       | `New-SysPassTag`              |   |
| tag/edit         | `Set-SysPassTag`              |   |
| tag/delete       | `Remove-SysPassTag`           |   |
| userGroup/search | `Find-SysPassUserGroup`       | ✅ |
| userGroup/view   | `Get-SysPassUserGroup`        |   |
| userGroup/create | `New-SysPassUserGroup`        |   |
| userGroup/edit   | `Set-SysPassUserGroup`        |   |
| userGroup/delete | `Remove-SysPassUserGroup`     |   |
| config/backup    | `Backup-SysPassConfig`        |   |
| config/export    | `Export-SysPassConfig`        |   |
