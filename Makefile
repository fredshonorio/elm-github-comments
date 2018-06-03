build: *.elm
	elm-make Main.elm --output comments.js 

watch: *.elm
	ls app_debug.html *.elm *.css | entr -cs "make build && xdotool search --onlyvisible --name 'app_debug.html' windowfocus key 'ctrl+r'"
