format:
	@echo "===> Format"
	stylua lua/

check:
	@echo "===> Check"
	lua-language-server --check .

test:
	@echo "===> Test"
	busted
