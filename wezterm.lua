-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Shorten wezterm.action to just 'act' for convenience
local act = wezterm.action

-- This is where you actually apply your config choices.
config.automatically_reload_config = true
config.window_close_confirmation = "AlwaysPrompt"

-- Font settings. ------------------------------------------------
config.use_ime = true

config.font_size = 12
config.font = wezterm.font("MesloLGM Nerd Font")
config.font = wezterm.font_with_fallback({
	"MesloLGM Nerd Font",
})

-- GUI settings. ------------------------------------------------
config.initial_cols = 130
config.initial_rows = 32

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():set_position(50, 100)
	-- window:gui_window():set_position(1400, 1000)
	-- window:gui_window():set_inner_size(5000, 2500)
	-- window:gui_window():set_inner_size(2000, 1000)
	-- pane:split({ size = 0.95, direction = "Top" })
	-- pane:split({ size = 0.5, direction = "Left" })
end)

-- or, changing the font size and color scheme.
config.color_scheme = "Vs Code Dark+ (Gogh)"

-- Background settings.
config.window_background_opacity = 0.90
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"

-- 1. デフォルトのシェル（+ボタンや起動時）を PowerShell に設定
-- (PowerShell 7なら 'pwsh.exe'、Windows標準なら 'powershell.exe')
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- 2. ランチャーメニューに表示するリストを定義
config.launch_menu = {
	-- Command Prompt の設定
	{
		label = "Command Prompt",
		args = { "cmd.exe" },
	},
	{
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	},
	{
		label = "PowerShell7",
		args = { "pwsh.exe", "-NoLogo" },
	},
}

config.keys = {
	-- 1. Ctrl + V で貼り付け
	{
		key = "v",
		mods = "CTRL",
		action = act.PasteFrom("Clipboard"),
	},

	-- 2. Ctrl + C の挙動を賢くする（選択範囲があればコピー、なければ中断信号を送る）
	{
		key = "c",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			-- 選択範囲のテキストを取得
			local selection_text = window:get_selection_text_for_pane(pane)

			-- 選択範囲が空でない（テキストを選択している）場合
			if selection_text ~= nil and selection_text ~= "" then
				-- クリップボードにコピー
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
			else
				-- 選択していなければ、本来の Ctrl+C（中断シグナル）を送信
				window:perform_action(act.SendKey({ key = "c", mods = "CTRL" }), pane)
			end
		end),
	},

	-- 3. Claude codeでShift+Enterで改行を送信
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action.SendString("\n"),
	},
}

-- Finally, return the configuration to wezterm:
return config
