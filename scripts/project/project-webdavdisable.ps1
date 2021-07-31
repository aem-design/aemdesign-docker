Param(
    [string]$SERVER_PATH_CONFIG_WEBDAV = "/apps/system/config/org.apache.sling.jcr.davex.impl.servlets.SlingDavExServlet",
    [string]$AEM_USERNAME = "admin",
    [string]$AEM_PASSWORD = "admin",
    [string]$LOGIN = "${AEM_USERNAME}:${AEM_PASSWORD}",
    [string]$AEM_HOST = "localhost",
    [string]$AEM_SCHEMA = "http",
    [string]$AEM_PORT = 4502,
    [string]$TIMEOUT = 5,
    [HashTable]$BODY = @{
        "jcr:primaryType"="sling:OsgiConfig"
        "alias"="/crx/server"
        "dav.create-absolute-uri"="true"
        "dav.create-absolute-uri@TypeHint"="Boolean"
        "../../jcr:primaryType"="sling:Folder"
        "../jcr:primaryType"="sling:Folder"
    },
    [string]$ADDRESS = "${AEM_SCHEMA}://${AEM_HOST}:${AEM_PORT}",
    [switch]$Silent = $false,
    [string]$FUNCTIONS_URI = "https://github.com/aem-design/aemdesign-docker/releases/latest/download/functions.ps1"
)

$SKIP_CONFIG = $true
$PARENT_PROJECT_PATH = "."

. ([Scriptblock]::Create((([System.Text.Encoding]::ASCII).getString((Invoke-WebRequest -Uri "${FUNCTIONS_URI}").Content))))


function doSlingPost {
	[CmdletBinding()]
	Param (

	    [Parameter(Mandatory=$true)]
	    [string]$Url="http://localhost:4502",

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Post','Delete')]
        [string]$Method,

	    [Parameter(Mandatory=$false)]
	    [HashTable]$Body,

	    [Parameter(Mandatory=$false,
        HelpMessage="Provide Basic Auth Credentials in following format: <user>:<pass>")]
	    [string]$BasicAuthCreds="",

	    [Parameter(Mandatory=$false)]
	    [string]$UserAgent="",

	    [Parameter(Mandatory=$false)]
	    [string]$Referer="",

	    [Parameter(Mandatory=$false)]
	    [string]$Timeout="5"

	)



    $HEADERS = @{
    }

    if (-not([string]::IsNullOrEmpty($UserAgent))) {
       $HEADERS.add("User-Agent",$UserAgent)
    }

    if (-not([string]::IsNullOrEmpty($Referer))) {
       $HEADERS.add("Referer",$Referer)
    }


    if (-not([string]::IsNullOrEmpty($BasicAuthCreds))) {
       $BASICAUTH = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($BasicAuthCreds))
       $HEADERS.add("Authorization","Basic $BASICAUTH")
    }


    Write-Output "Performing action $Method on $Url."

    (Invoke-WebRequest -Method Post -Headers $HEADERS -TimeoutSec $Timeout -Uri "$Url" -Body $Body -ContentType "application/x-www-form-urlencoded").Content

    Write-Output "Body:"

    $Body | ConvertTo-Json

}

Write-Output "SERVER_PATH_CONFIG_WEBDAV: $SERVER_PATH_CONFIG_WEBDAV"
Write-Output "AEM_HOST: $AEM_HOST"
Write-Output "AEM_SCHEMA: $AEM_SCHEMA"
Write-Output "AEM_PORT: $AEM_PORT"
Write-Output "TIMEOUT: $TIMEOUT"
Write-Output "Silent: $Silent"
Write-Output "BODY `t {"
$BODY.GetEnumerator().ForEach({ "`t   $($_.Name) = $($_.Value)`r" })
Write-Output "`t }"
Write-Output "ADDRESS: $ADDRESS"

if (-not($Silent))
{
    $START = Read-Host -Prompt 'Do you want to disable WebDav? (y/n)'

    if ($START -ne "y")
    {
        Write-Output "Quiting..."
        Exit
    }
}

#Disable WebDav
doSlingPost -Method Delete -Referer $ADDRESS -UserAgent "curl" -Url ${ADDRESS}${SERVER_PATH_CONFIG_WEBDAV} -BasicAuthCreds $LOGIN -Timeout $TIMEOUT
# curl -u admin:admin -H User-Agent:curl -X DELETE http://localhost:4502/apps/system/config/org.apache.sling.jcr.davex.impl.servlets.SlingDavExServlet

#Enable WebDav
#doSlingPost -Body $BODY -Method Post -Referer $ADDRESS -UserAgent "curl" -Url ${ADDRESS}${SERVER_PATH_CONFIG_WEBDAV} -BasicAuthCreds $LOGIN -Timeout $TIMEOUT
# curl -u admin:admin -H User-Agent:curl -F "jcr:primaryType=sling:OsgiConfig" -F "alias=/crx/server" -F "dav.create-absolute-uri=true" -F "dav.create-absolute-uri@TypeHint=Boolean" -F"../../jcr:primaryType=sling:Folder" -F"../jcr:primaryType=sling:Folder" http://localhost:4502/apps/system/config/org.apache.sling.jcr.davex.impl.servlets.SlingDavExServlet



