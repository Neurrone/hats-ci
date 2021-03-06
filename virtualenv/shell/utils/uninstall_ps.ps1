echo "Uninstalling hats"

$path_to_hats = "$env:PROGRAMFILES\hats"

echo "Terminating any running instances of web drivers"
Stop-Process -processname chromedriver, geckodriver, IEDriverServer -ErrorAction silentlycontinue

echo "Removing system path entry"
$path = [Environment]::GetEnvironmentVariable('PATH', 'Machine');
$path = ($path.Split(';') | Where-Object { $_ -ne "$env:HATS" }) -join ';'
[Environment]::SetEnvironmentVariable("PATH", $path, 'Machine');
[Environment]::SetEnvironmentVariable("HATS",$null, [System.EnvironmentVariableTarget]::Machine)

echo "Removing all hats files"

cd "$path_to_hats"
Get-ChildItem *.* -recurse | Where { ! $_.PSIsContainer } | remove-item
