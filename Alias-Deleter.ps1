﻿#pfSense host deleter script
# Author: Sebastian Tennant

# Dependancies: https://github.com/jaredhendrickson13/pfsense-api 
# set to API Token authentication

# Comments:
# This was designed so I could easily take my gaming computer in and out of an alias group within my pfSense router
# I have two internet connections, one though HFC (NBN Australia) and the other through Starlink. Starlink is faster, but NBN has better latency as it isn't satellite.
# I generally use Starlink for game updates, etc - but when playing online, it is better to be routed through NBN.

Function Menu 
{
    Clear-Host        
    Do
    {
        Clear-Host                                                                       
        Write-Host -Object 'pfSense Host Deleter'
        Write-Host     -Object '**********************'
        Write-Host -Object 'This removes this computer out of an alias list, which in turn will make Starlink the primary failover group' -ForegroundColor Yellow
        Write-Host     -Object '**********************'
        Write-Host -Object '1.  Remove this computer '
    Write-Host -Object ''
        Write-Host -Object '2.  Add this computer '
    Write-Host -Object ''
    Write-Host -Object ''
        Write-Host -Object 'Q.  Quit'
        Write-Host -Object $errout
        $Menu = Read-Host -Prompt '(0-2 or Q to Quit)'
 
        switch ($Menu) 
        {
           1 
            {
$headers=@{}
$headers.Add("user-agent", "vscode-restclient")
$headers.Add("authorization", "X X")
$headers.Add("content-type", "application/json")
$response = Invoke-WebRequest -Uri 'https://pfsense.internal.tennant.id.au/api/v1/firewall/alias/entry' -Method DELETE -Headers $headers -ContentType 'application/json' -Body '{"name": "NBN_Primary","address": ["10.4.20.140"]}'

            }
            2 
            {
$headers=@{}
$headers.Add("user-agent", "vscode-restclient")
$headers.Add("authorization", "X X")
$headers.Add("content-type", "application/json")
$response = Invoke-WebRequest -Uri 'https://pfsense.internal.tennant.id.au/api/v1/firewall/alias/entry' -Method POST -Headers $headers -ContentType 'application/json' -Body '{"name": "NBN_Primary","address": ["10.4.20.140"]}'
Write-Host "Added 10.4.20.140 - NBN now primary"
            }
            3 
            {
                RevertSpecificVMSnapshot
                anyKey
            }
            Q 
            {
                Exit
            }   
            default
            {
                $errout = 'Invalid option please try again........Try 1-2 or Q only'
            }
 
        }
    }
    until ($Menu -eq 'q')
}   
 
# Launch The Menu
Menu