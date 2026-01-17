# Microsoft.PowerShell_profile.ps1

# oh-my-poshの初期化
# シェルの種類を自動判定 (PS 7以上なら 'pwsh'、それ以外なら 'powershell')
$omp_shell = if ($PSVersionTable.PSVersion.Major -ge 7) { "pwsh" } else { "powershell" }

# oh-my-poshの初期化 (判定したシェル名を渡す)
# ※エラーが出る場合は --config でテーマファイルを明示的に指定してみてください
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init $omp_shell --config ~/dotfiles/PowerShell/mytheme.json | Invoke-Expression
    Import-Module posh-git
}

# pixiの補完スクリプトの読み込み
(& pixi completion --shell powershell) | Out-String | Invoke-Expression

# Claude Code設定
$env:CLAUDE_CODE_GIT_BASH_PATH="C:\Users\aoxor\scoop\apps\git\current\bin\bash.exe"
