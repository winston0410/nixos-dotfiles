local eslint = {
	lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m" },
	lintIgnoreExitCode = true,
	-- formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
	-- formatStdin = true
}

local htmlhint = {
	lintCommand = "",
	lintStdin = true,
	lintFormats = {},
}

local hadolint = {
	lintCommand = "hadolint --no-color",
	lintFormats = {
		"%f:%l %m",
	},
}

local shellcheck = {
	lintCommand = "shellcheck -f gcc -x -",
	lintStdin = true,
	lintFormats = {
		"%f:%l:%c: %trror: %m",
		"%f:%l:%c: %tarning: %m",
		"%f:%l:%c: %tote: %m",
	},
}

local yamllint = { lintCommand = "yamllint -f parsable -", lintStdin = true }

local markdownlint = {
	lintIgnoreExitCode = true,
	lintCommand = "markdownlint -s",
	lintStdin = true,
	lintFormats = {
		"%f:%l %m",
		"%f:%l:%c %m",
		"%f: %l: %m",
	},
}

local dotenv_linter = {
	lintCommand = "dotenv-linter --no-color",
	lintFormats = {
		"%f:%l %m",
	},
	lintStdin = true,
	lintSource = "dotenv-linter",
	lintIgnoreExitCode = true,
}

local jsonlint = {
	lintCommand = "jsonlint",
	lintIgnoreExitCode = true,
	-- lintFormats = {"%f:%l:%c: %m"}
}

local golint = {
	lintCommand = "golint",
	lintIgnoreExitCode = true,
	lintFormats = { "%f:%l:%c: %m" },
}

local flake8 = {
	lintCommand = "flake8 --stdin-display-name ${INPUT} -",
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m" },
}

local checkmake = {
	lintCommand = "checkmake",
	lintStdin = true,
}

local vint = {
	lintCommand = "vint --enable-neovim --",
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m" },
	lintSource = "vint",
}

local svelte_check = {
	lintCommand = "svelte-check",
	lintStdin = true,
}

return {
	javascript = { eslint },
	html = { htmlhint },
	javascriptreact = { eslint },
	["javascript.jsx"] = { eslint },
	typescript = { eslint },
	typescriptreact = { eslint },
	["typescript.jsx"] = { eslint },
	dockerfile = { hadolint },
	sh = { shellcheck },
	zsh = { shellcheck },
	markdown = { markdownlint },
	dotenv = { dotenv_linter },
	yaml = { yamllint },
	json = { jsonlint },
	go = { golint },
	python = { flake8 },
	make = { checkmake },
	vim = { vint },
	svelte = { svelte_check },
}
