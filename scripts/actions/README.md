# GitHub Actions Pipeline Monitoring Script

PowerShell script for monitoring GitHub Actions workflow runs with automatic log management.

## Features

✅ **Auto-detect current commit** - Shows pipeline status for your current working commit  
✅ **Smart log caching** - Saves logs locally and skips re-downloading  
✅ **Clean output** - Displays workflow status in an easy-to-read card format  
✅ **Wait for completion** - Poll and wait for running workflows to finish  
✅ **Real-time watching** - Watch running workflows with live updates  
✅ **Multiple filtering** - Filter by status, workflow name, or run count  
✅ **GitHub CLI powered** - Uses `gh` for authentication and API access  

## Prerequisites

### GitHub CLI Installation

The script requires the GitHub CLI (`gh`) to be installed and authenticated.

```powershell
# Install GitHub CLI
winget install --id GitHub.cli

# Authenticate with GitHub
gh auth login
```

### Verify Installation

```powershell
# Check version
gh --version

# Check authentication
gh auth status
```

## Installation

Copy `get-action-logs.ps1` to your repository root:

```powershell
# From the actions directory
cp get-action-logs.ps1 /path/to/your/repo/
```

## Usage

### Basic Commands

```powershell
# Show current commit's pipeline status (default behavior)
.\get-action-logs.ps1

# Wait for pipeline to complete
.\get-action-logs.ps1 -WaitForCompletion

# Show logs in console
.\get-action-logs.ps1 -ShowLogs

# Force re-download existing logs
.\get-action-logs.ps1 -Force
```

### Advanced Commands

```powershell
# View specific run's logs
.\get-action-logs.ps1 -RunId 12345678 -ViewLogs

# Download logs as zip file
.\get-action-logs.ps1 -RunId 12345678 -Download

# Watch running workflow in real-time
.\get-action-logs.ps1 -Watch

# List last 10 runs
.\get-action-logs.ps1 -Limit 10

# Show only failed runs
.\get-action-logs.ps1 -Status failure

# Filter by workflow file
.\get-action-logs.ps1 -Workflow "build.yml"

# Disable auto-save logs
.\get-action-logs.ps1 -SaveLogs:$false

# Explicitly check current commit
.\get-action-logs.ps1 -CurrentCommit

# Current commit + wait + show logs
.\get-action-logs.ps1 -CurrentCommit -WaitForCompletion -ShowLogs
```

### Combined Options

```powershell
# Wait for completion and show logs
.\get-action-logs.ps1 -WaitForCompletion -ShowLogs

# Current commit, wait, and show logs when done
.\get-action-logs.ps1 -CurrentCommit -WaitForCompletion -ShowLogs

# Show last 5 failed runs
.\get-action-logs.ps1 -Limit 5 -Status failure

# Wait for specific run and view logs
.\get-action-logs.ps1 -RunId 12345678 -WaitForCompletion -ViewLogs
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `-Limit` | int | 5 | Number of recent runs to show |
| `-Workflow` | string | "" | Filter by workflow file name (e.g., "build.yml") |
| `-Status` | string | "" | Filter by status (completed, failure, success, etc.) |
| `-ViewLogs` | switch | false | View full logs of the latest/specified run |
| `-Download` | switch | false | Download logs as zip file |
| `-RunId` | string | "" | Specific run ID to view/download |
| `-Watch` | switch | false | Watch a running workflow in real-time |
| `-WaitForCompletion` | switch | false | Wait for workflow run to complete |
| `-PollInterval` | int | 10 | Seconds between status checks when waiting |
| `-CurrentCommit` | switch | false | Find workflow runs for current git HEAD commit |
| `-ShowLogs` | switch | false | Display logs when finding current commit's pipeline |
| `-SaveLogs` | bool | $true | Save logs to logs/ folder (use `-SaveLogs:$false` to disable) |
| `-Force` | switch | false | Force re-download of logs even if they exist |

## Output

### Status Card Format

```
====================================================================================================
  ✓ build
  Run ID       : 18709640324
  Title        : fix: make dive analysis optional to not block pipeline
  Status       : completed
  Conclusion   : success
  Branch       : main
  Event        : push
  Created      : 10/22/2025 08:08:24
  URL          : https://github.com/aem-design/docker-dispatcher-sdk/actions/runs/18709640324
  Log file     : logs/run-18709640324-780320e-build-success.log
====================================================================================================
```

### Status Icons

- ✓ = Success (Green)
- ✗ = Failure (Red)
- ⊘ = Cancelled (Yellow)
- ⊖ = Skipped (Gray)
- ● = In Progress/Unknown (Cyan)

### Log File Naming

Logs are saved with a consistent naming pattern:

```
logs/run-{runId}-{commitSha}-{workflowName}-{conclusion}.log
```

**Examples:**
- `logs/run-18709640324-780320e-build-success.log`
- `logs/run-18705686914-38efdc2-build-failure.log`
- `logs/run-18722094176-3415f7e-build-success.log`

### Log File Indicators

- **Green text**: Log file exists locally
- **Gray text**: Log file not downloaded yet

## Examples

### Example 1: Check Pipeline After Commit

```powershell
# Make changes
git add .
git commit -m "fix: update configuration"
git push

# Check pipeline status
.\get-action-logs.ps1

# Wait for it to finish
.\get-action-logs.ps1 -WaitForCompletion
```

### Example 2: Debug Failed Pipeline

```powershell
# Check current status
.\get-action-logs.ps1

# If failed, view the logs
.\get-action-logs.ps1 -ShowLogs

# Or view a specific run
.\get-action-logs.ps1 -RunId 18709640324 -ViewLogs
```

### Example 3: Monitor Long-Running Build

```powershell
# Start watching the build
.\get-action-logs.ps1 -Watch

# Or wait and auto-show logs when complete
.\get-action-logs.ps1 -WaitForCompletion -ShowLogs
```

### Example 4: Review Recent Failures

```powershell
# List last 10 failed runs
.\get-action-logs.ps1 -Limit 10 -Status failure

# View logs for a specific failed run
.\get-action-logs.ps1 -RunId 12345678 -ViewLogs
```

## Workflow Integration

This script is designed to work with GitHub Actions workflows that follow standard patterns. It's particularly useful for:

- Docker image builds
- Multi-platform builds
- CI/CD pipelines with testing
- Release automation
- Tag-based deployments

## Log Management

### Auto-Save Behavior

- Logs are **automatically saved** to `logs/` folder by default
- **Skips re-downloading** if log file already exists
- Use `-Force` to override and re-download
- Use `-SaveLogs:$false` to disable saving entirely

### Log Folder Structure

```
your-repo/
├── .github/
│   └── workflows/
│       └── build.yml
├── get-action-logs.ps1
└── logs/
    ├── run-18709640324-780320e-build-success.log
    ├── run-18705686914-38efdc2-build-failure.log
    └── run-18722094176-3415f7e-build-success.log
```

**Note**: Add `logs/` to your `.gitignore` to prevent committing log files.

## Troubleshooting

### "gh: command not found"

Install GitHub CLI:

```powershell
winget install --id GitHub.cli
```

Or download from: https://cli.github.com/

### "Not authenticated with GitHub"

Authenticate with GitHub:

```powershell
gh auth login
```

Follow the prompts to authenticate via browser or token.

### "No workflow runs found"

This can happen if:
- The commit hasn't been pushed yet
- Workflows haven't triggered
- You're in a detached HEAD state

**Solution**: Ensure your commit is pushed and workflows are configured correctly.

### Log File Shows "(not downloaded)"

This is normal if:
- Running without `-SaveLogs` parameter (though it's default $true)
- First time running the script for this commit

**Solution**: The script will download logs on first run. Subsequent runs will use cached logs.

## Script Help

For detailed parameter information:

```powershell
Get-Help .\get-action-logs.ps1 -Full
```

## Exit Codes

- `0` - Success or workflow completed successfully
- `1` - Error or workflow failed/cancelled

Use exit codes in CI/CD scripts:

```powershell
.\get-action-logs.ps1 -WaitForCompletion
if ($LASTEXITCODE -eq 0) {
    Write-Host "Pipeline passed!"
} else {
    Write-Host "Pipeline failed!"
    exit 1
}
```

## Best Practices

1. **Run after pushing**: Always check pipeline status after pushing commits
2. **Use WaitForCompletion**: For automated scripts that depend on build success
3. **Review logs**: When tests fail, use `-ShowLogs` to see detailed error messages
4. **Keep logs/ in .gitignore**: Don't commit log files to the repository
5. **Use -Force sparingly**: Only re-download when you suspect logs are corrupted

## Version

This script requires:
- PowerShell 5.1 or later
- GitHub CLI (`gh`) version 2.0 or later
- Git (for commit detection)

## License

Same license as the parent repository.

## Contributing

To improve this script:

1. Test changes thoroughly
2. Update this README with new features
3. Maintain backward compatibility
4. Follow PowerShell best practices

## Support

For issues or questions:
- Check GitHub Actions workflow runs: https://github.com/{org}/{repo}/actions
- Review GitHub CLI documentation: https://cli.github.com/manual/
- Check PowerShell help: `Get-Help .\get-action-logs.ps1 -Full`

