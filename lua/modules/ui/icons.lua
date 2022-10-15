-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet
vim.g.use_nerd_icons = true
if vim.g.use_nerd_icons then
	return {
		kind = {
			-- Class = " ",
			-- Constructor = "",
			-- Keyword = "",
			-- Method = "m",
			-- Module = "",
			-- Snippet = " ",
			Class = "",
			Color = "",
			Constant = "",
			Constructor = "",
			Enum = "",
			EnumMember = "",
			Event = "",
			Field = "",
			File = "",
			Folder = "",
			Function = "",
			Interface = "",
			Keyword = "",
			Method = "",
			Module = "",
			Namespace = "",
			Number = "#",
			Operator = "",
			Package = "",
			Property = "ﰠ",
			Reference = "",
			Snippet = "",
			Struct = "",
			Text = "",
			TypeParameter = "",
			Unit = "",
			Value = "",
			Variable = "",
			-- ccls-specific icons.
			TypeAlias = "",
			Parameter = "",
			StaticMethod = "",
			Macro = "",
		},
		type = {
			-- Array = "",
			Array = "",
			Boolean = "",
			Null = "ﳠ",
			Number = "#",
			Object = "⦿",
			String = "",
		},
		documents = {
			Default = "",
			File = "",
			Files = "",
			FileTree = "פּ",
			Symlink = "",
		},
		git = {
			Add = "",
			Branch = "",
			Diff = "",
			Git = "",
			Ignore = "",
			Mod = "M",
			Mod_alt = "",
			Remove = "",
			Rename = "",
			Repo = "",
			Unmerged = "",
			Untracked = "U",
			Unstaged = "",
			Staged = "",
			Conflict = "",
		},
		ui = {
			ArrowClosed = "",
			ArrowOpen = "",
			BigCircle = "",
			BigUnfilledCircle = "",
			BookMark = "",
			Bug = "",
			Calendar = "",
			Check = "",
			ChevronRight = "",
			Circle = "",
			Close = "",
			Close_alt = "",
			CloudDownload = "",
			Comment = "",
			CodeAction = "💡",
			Dashboard = "",
			Emoji = "",
			EmptyFolder = "",
			EmptyFolderOpen = "",
			File = "",
			Fire = "",
			Folder = "",
			FolderOpen = "",
			Gear = "",
			History = "",
			-- Indicator = "",
			Indicator = "",
			Left = "",
			Lightbulb = "",
			List = "",
			SymlinkFolder = "",
			Lock = "",
			Modified = "✥",
			NewFile = "",
			Note = "",
			Package = "",
			Pencil = "",
			Perf = "",
			Project = "",
			Right = "",
			Search = "",
			Separator = "",
			SignIn = "",
			SignOut = "",
			Sort = "",
			Spell = "暈",
			Symlink = "",
			Table = "",
			Telescope = "",
		},
		diagnostics = {
			Error = "",
			Warning = "",
			Information = "",
			Question = "",
			Hint = "",
			-- Holo version
			Error_alt = "",
			Warning_alt = "",
			Information_alt = "",
			Question_alt = "",
			Hint_alt = "",
		},
		misc = {
			Campass = "",
			Code = "",
			EscapeST = "✺",
			Gavel = "",
			Glass = "",
			PyEnv = "",
			Squirrel = "",
			Tag = "",
			Tree = "",
			Watch = "",
			Lego = "",
			Vbar = "│",
		},
		cmp = {
			Copilot = "",
			Copilot_alt = "",
			nvim_lsp = "",
			nvim_lua = "",
			path = "",
			buffer = " ",
			spell = "暈",
			luasnip = "",
			treesitter = "",
		},
		dap = {
			Breakpoint = "ß",
			BreakpointCondition = "ü",
			BreakpointRejected = "",
			LogPoint = "",
			Pause = "",
			Play = "",
			RunLast = "↻",
			StepBack = "",
			StepInto = "",
			StepOut = "",
			StepOver = "",
			Stopped = "ඞ",
			Terminate = "ﱢ",
		},
	}
end
