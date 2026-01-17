# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## コミュニケーション規約

- 日本語を使用する
- 読点は「，」，句点は「。」を使用する

## 文章作成時のルール

- 文章は「です」「ます」調ではなく，「である」「だ」調で統一すること
- 認識が統一できるように，専門的な表現を使用すること

## リポジトリ概要

Windows開発環境の設定ファイル（dotfiles）を管理するリポジトリである。

### 管理ファイル

- `.wezterm.lua` - WezTermターミナルエミュレータの設定（Lua）
- `Microsoft.PowerShell_profile.ps1` - PowerShellプロファイル（Windows PowerShell/PowerShell Core共用）

## セットアップ

設定ファイルはシンボリックリンクまたはハードリンクで有効化する。詳細はREADME.mdを参照。

## 変更方針

200行以上の大規模な変更が見込まれる場合，変更計画を事前に提案し，合意を得ること。
