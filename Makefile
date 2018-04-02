build: Main.elm
	elm-make Main.elm --output comments.js 

watch: 
	ls app_debug.html *.elm | entr make build
