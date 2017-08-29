#!/bin/bash

if [ -f "/usr/bin/osascript" ]; then
	"/usr/bin/osascript" -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
fi 

PWD=`pwd`
export NODE_ENV=local
export PATH=/opt/node/current/bin/:$PWD/sparx/node_modules/.bin/:$PATH
export NODE_PATH=./:$PWD/sparx/lib:./:$PWD/sparx:$PWD/sparx/node_modules

node -v

#npm config set ca=""
#npm link

#npm install -g jshint
#npm link

#node-gyp configure build

node ./test/fixture.js
echo finished fixture

node ./test/parse.js
echo finished parse

node ./test/write.js
echo finished write

#if [ -z "$1" ]; then
#mocha --timeout 80000 -b ./test/fixture.js
#mocha --timeout 80000 -b ./test/parse.js
#mocha --timeout 80000 -b ./test/write.js

#else
#	mocha --timeout 80000 -b ./sparx/tests/api2.js --suite-grep=$1
#fi 




