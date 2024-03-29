# Licensed under the Tumbolia Public License. See footer for details.

.PHONY: build test vendor

#-------------------------------------------------------------------------------
all: test

#-------------------------------------------------------------------------------
clean:
	@rm -rf lib
	@rm -rf tmp

#-------------------------------------------------------------------------------
build: tmp package.json build-shelley build-bin build-samples

#-------------------------------------------------------------------------------
package.json: package.cson
	@echo "--------> building package.json"

	@echo building package.json
	@-rm -rf tmp/*
	@node_modules/.bin/coffee --compile --bare --output tmp package.cson
	@echo "function packageJSON(x) { console.log(JSON.stringify(x,null,4))}" > tmp/tmp.js
	@echo "packageJSON" >> tmp/tmp.js
	@cat  tmp/package.js >> tmp/tmp.js
	@node tmp/tmp.js > package.json

#-------------------------------------------------------------------------------
build-shelley: 
	@echo "--------> building lib/shelley.js"

    # erase the ./lib directory
	-@rm -rf lib/*

    # pre-compile just to get syntax errors, since browserify doesn't
	@-rm -rf tmp/*

	@node_modules/.bin/coffee --compile --output tmp         lib-src/*.coffee
	@node_modules/.bin/coffee --compile --output tmp/persist lib-src/persist/*.coffee
	@node_modules/.bin/coffee --compile --output tmp/models  lib-src/models/*.coffee

    # copy our pesto modules over for browserify
	@rm -rf tmp/*
	@-mkdir tmp/shelley

	@cp -R lib-src/*               tmp/shelley
	@echo "require('./shelley')" > tmp/index.js
	
    # copy over 3rd party modules
	@cp node_modules/backbone/backbone.js     tmp
	@cp node_modules/underscore/underscore.js tmp

    # run browserify
	@echo "running browserify (rel)"
	@node_modules/.bin/browserify tmp/index.js \
        --verbose \
        --alias 'shelley:/shelley' \
        --outfile lib/shelley.js

    # run browserify
	@echo "running browserify (dev)"
	@node_modules/.bin/browserify tmp/index.js \
        --debug \
        --alias 'shelley:/shelley' \
        --outfile lib/shelley-debug.js

	@touch tmp/build-done.txt

#-------------------------------------------------------------------------------
build-bin:
	@echo "--------> building bin"

	@rm -rf bin/*
	@cp bin-src/shelley bin
	@node_modules/.bin/coffee --bare --compile --output bin bin-src/*.coffee


#-------------------------------------------------------------------------------
build-samples:
	@cd samples; make

#-------------------------------------------------------------------------------
tmp:
	@-mkdir tmp

#-------------------------------------------------------------------------------
test: build test-browser
	@echo "--------> test TBD"

#-------------------------------------------------------------------------------
test-browser:
	@echo "--------> building test (browser)"

	@-rm -rf test/*
	@-cp test-src/*.html test/

    # compile coffeescript
	@node_modules/.bin/coffee --compile --output test test-src/*.coffee

#-------------------------------------------------------------------------------
test-node: 
	@node_modules/.bin/mocha \
	    --ui bdd \
	    --compilers coffee:coffee-script \
	    --reporter progress \
	    test-src/*.coffee
	

#-------------------------------------------------------------------------------
vendor: vendor-init vendor-jasmine vendor-jquery-ui

#-------------------------------------------------------------------------------
vendor-init:
	@echo Downloading third party goop

    # installing npm modules

	@npm install

    # installing stuff for the browser

	@rm -rf vendor
	@mkdir vendor

#-------------------------------------------------------------------------------
vendor-jquery-ui:
	@echo Downloading jquery-ui
	
    # installing jquery, coffee-script, mustache

	@curl --output vendor/jquery.js        --progress-bar http://code.jquery.com/jquery-$(VERSION_JQUERY).min.js

    # installing jquery ui

	@rm -rf tmp
	@mkdir  tmp

	@mkdir vendor/jquery-ui
	@mkdir vendor/jquery-ui/themes
	@mkdir vendor/jquery-ui/themes/images

	@curl --progress --out tmp/jquery-ui.zip http://jqueryui.com/download/jquery-ui-$(VERSION_JQUERY_UI).custom.zip
	@unzip -q tmp/jquery-ui.zip -d tmp
	@cp tmp/development-bundle/ui/jquery-ui-$(VERSION_JQUERY_UI).custom.js   vendor/jquery-ui/jquery-ui.js
	@cp tmp/development-bundle/themes/base/images/*                          vendor/jquery-ui/themes/images
	@cp tmp/development-bundle/themes/smoothness/jquery-ui-1.8.20.custom.css vendor/jquery-ui/themes/smoothness.css

#-------------------------------------------------------------------------------
vendor-jasmine: 
	@echo Downloading jasmine

#   get jasmine browserable bits
	@rm -rf tmp
	@mkdir  tmp
	@curl --progress-bar \
	   --output tmp/jasmine.zip \
	   http://cloud.github.com/downloads/pivotal/jasmine/jasmine-standalone-$(VERSION_JASMINE).zip
	@unzip tmp/jasmine.zip -d tmp

#   copy jasmine browserable bits to /vendor/jasmine
	@mv tmp/lib/jasmine-$(VERSION_JASMINE) vendor/jasmine

#-------------------------------------------------------------------------------

VERSION_JQUERY        = 1.7.1
VERSION_JQUERY_UI     = 1.8.20
VERSION_JASMINE       = 1.2.0

#-------------------------------------------------------------------------------
# Copyright (c) 2012 Patrick Mueller
# 
# Tumbolia Public License
# 
# Copying and distribution of this file, with or without modification, are
# permitted in any medium without royalty provided the copyright notice and this
# notice are preserved.
# 
# TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
# 
#   0. opan saurce LOL
#-------------------------------------------------------------------------------
