Param(
    [string]$LOG_PATH = "logs",
    [string]$LOG_PEFIX = "serve",
    [string]$LOG_SUFFIX = ".log",
    [string]$DOCKER_LOGS_FOLDER = "logs",
    [string]$FUNCTIONS_URI = "https://github.com/aem-design/aemdesign-docker/releases/latest/download/functions.ps1",
    [string]$DOCKER_COMMAND = "docker run -it -v ${PWD}:/build/source -p 4504:4504 -v ${HOME}/.m2:/build/.m2 --net=host aemdesign/centos-java-buildpack:jdk8 /bin/bash --login -c 'cd /build/source/thehub-compose && yarn serve:core'"
)

$SKIP_CONFIG = $true
$PARENT_PROJECT_PATH = "."

. ([Scriptblock]::Create((([System.Text.Encoding]::ASCII).getString((Invoke-WebRequest -Uri "${FUNCTIONS_URI}").Content))))

$script:LOG_PATH = $LOG_PATH

printSectionBanner "Stopping Selenium Hub containers"

printSectionLine "Run and Mount current folder into container..."

Invoke-Expression -Command "${DOCKER_COMMAND}"

