-- Description: This is my main NeoVim configuration repository.
--
return {
	"sobh/nvim.conf",
	url = "git@github.com:sobh/nvim.conf",
	name = "sobh",
	config = function()
		require("sobh.config.options").setup()
	end,
}
