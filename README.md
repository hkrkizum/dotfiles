# Dotfiles

個人の開発環境設定ファイル（Dotfiles）を管理するリポジトリである

## 1. 管理している設定

- **WezTerm**: ターミナルエミュレータの設定 (`wezterm.lua`)
- **PowerShell**: シェルのプロファイル (`Microsoft.PowerShell_profile.ps1`)

## 2. 開発環境のセットアップ

Windowsの開発環境を構築するために，以下のツールをインストールする．

### 2.1. パッケージマネージャーのインストール

#### 2.1.1. Scoop

ScoopはWindows向けのパッケージマネージャーである．以下のコマンドでインストールする．

```powershell
# Scoopのインストール
iwr -useb get.scoop.sh | iex
```

#### 2.1.2. winget

wingetはWindows Package Managerで，デフォルトでインストールされている．

### 2.2. Scoopでのツールインストール

以下のコマンドでツールをインストールする．

```powershell
scoop install 7zip
scoop install git
scoop install r
scoop install wezterm
scoop install pixi
```

### 2.3. wingetでのツールインストール

以下のコマンドでツールをインストールする．

```powershell
winget install Microsoft.VisualStudioCode
winget install Microsoft.VisualStudio.Community
winget install Rustlang.Rustup
winget install Microsoft.PowerShell
winget install Microsoft.WindowsTerminal
winget install JanDeDobbeleer.OhMyPosh
winget install Posit.Positron
```

### 2.4. `uv`の設定

```powershell
pixi global install uv
```

### 2.5. ツールのインストール

```powershell
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

## 3. セットアップ

設定ファイルを有効にするには，PowerShellを使用してリンクを作成する。

### 3.1. リンクの作成方法について

環境に合わせて，**シンボリックリンク**（推奨）または **ハードリンク** を選択する。

- **シンボリックリンク** (`SymbolicLink`): Windowsの「開発者モード」が有効，または管理者権限がある場合に使用。
- **ハードリンク** (`HardLink`): 権限がない場合の代替手段（同一ドライブ内限定）。

### 3.2. WezTerm

#### 3.2.1. 方法 1: シンボリックリンク

ホームディレクトリに `.wezterm.lua` としてリンクを作成する。

```powershell
# シンボリックリンク
New-Item -ItemType SymbolicLink -Path "$HOME\.wezterm.lua" -Target "$PWD\wezterm.lua"
```

#### 3.2.2. 方法 2: ハードリンク

```powershell
New-Item -ItemType HardLink -Path "$HOME\.wezterm.lua" -Target "$PWD\wezterm.lua"
```

### 3.3. PowerShell

Windows PowerShell (`powershell.exe`) と PowerShell Core (`pwsh.exe`) の両方で同じ設定ファイルを使用する。
以下のコマンドを実行すると，両方のプロファイルパスに対してリンクが作成される。

#### 3.3.1. 方法 1: シンボリックリンク

```powershell
$Target = "$PWD\Microsoft.PowerShell_profile.ps1"
$Links = @(
    "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1",
    "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
)

foreach ($Link in $Links) {
    if (!(Test-Path (Split-Path $Link))) { New-Item -Type Directory -Path (Split-Path $Link) -Force }
    New-Item -ItemType SymbolicLink -Path $Link -Target $Target -Force
}

New-Item -ItemType SymbolicLink -Path "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Target "$PWD\Microsoft.PowerShell_profile.ps1" -Force

New-Item -ItemType SymbolicLink -Path "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "$PWD\Microsoft.PowerShell_profile.ps1" -Force
```

#### 3.3.2. 方法 2: ハードリンク

```powershell
$Target = "$PWD\Microsoft.PowerShell_profile.ps1"
$Links = @(
    "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1",
    "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
)

foreach ($Link in $Links) {
    if (!(Test-Path (Split-Path $Link))) { New-Item -Type Directory -Path (Split-Path $Link) -Force }
    New-Item -ItemType HardLink -Path $Link -Target $Target -Force
}
```

### 3.4. Git Hooks

リポジトリのhooksディレクトリを使用するように設定する。

```powershell
git config core.hooksPath hooks
```
