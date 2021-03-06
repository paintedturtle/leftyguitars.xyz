nodes: leftyguitars.xyz paintedturtle.github

leftyguitars.xyz:
	ssh core@leftyguitars.xyz "mkdir -p spaces/leftyguitars.xyz; git init --bare spaces/leftyguitars.xyz.git"
	scp leftyguitars.xyz.git-post-receive-hook core@leftyguitars.xyz:spaces/leftyguitars.xyz.git/hooks/post-receive
	ssh core@leftyguitars.xyz "chmod +x spaces/leftyguitars.xyz.git/hooks/post-receive"
	git push leftyguitars.xyz master

paintedturtle.github:
	git push paintedturtle.github master

d3.min.js: node_modules/d3/d3.min.js
	cp node_modules/d3/d3.min.js d3.min.js

git:
	git init
	git config user.email "•"
	git config user.name "la torture peinte"
	git remote add leftyguitars.xyz core@leftyguitars.xyz:spaces/leftyguitars.xyz.git
	git remote add paintedturtle.github git@github.com:paintedturtle/leftyguitars.xyz.git
