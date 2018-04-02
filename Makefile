build: *.elm
	elm-make Main.elm --output comments.js 

watch: *.elm
	ls app_debug.html *.elm | entr make build
