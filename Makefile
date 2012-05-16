# Licensed under the Tumbolia Public License. See footer for details.

.PHONY: build test vendor

#-------------------------------------------------------------------------------
all: build

#-------------------------------------------------------------------------------
clean:
	@rm -rf lib
	@rm -rf tmp

#-------------------------------------------------------------------------------
build: tmp build-shelley build-samples

#-------------------------------------------------------------------------------
build-shelley:
	@echo building lib/shelley.js directory

    # erase the ./lib directory
	-@rm -rf lib/*

    # pre-compile just to get syntax errors, since browserify doesn't
	@-rm -rf tmp/*

	@node_modules/.bin/coffee -c -o tmp \
	    lib-src/*.coffee

    # copy our pesto modules over for browserify
	@rm -rf tmp/*
	@mkdir tmp/shelley

	@cp -R lib-src/*               tmp/shelley
	@echo "require('./shelley')" > tmp/index.js

    # copy over 3rd party modules
	@cp node_modules/backbone/backbone.js     tmp
	@cp node_modules/underscore/underscore.js tmp

    # run browserify
	@echo "   running browserify"
	@node_modules/.bin/browserify tmp/index.js \
	    --outfile lib/shelley.js \
	    --debug --verbose

	@touch tmp/build-done.txt

#-------------------------------------------------------------------------------
build-samples: build-sample-about

#-------------------------------------------------------------------------------
build-sample-about:

    # pre-compile just to get syntax errors, since browserify doesn't
	@-rm -rf tmp/*

	@node_modules/.bin/coffee -c -o tmp \
	    samples/about/*.coffee

    # run browserify
	@echo "   running browserify"
	@node_modules/.bin/browserify \
	    --debug --verbose \
	    --prelude false \
	    --ignore backbone \
	    --ignore underscore \
	    --ignore shelley \
	    --ignore '/shelley' \
	    --alias 'shelley:/shelley' \
	    --outfile samples/about/modules.js \
	              samples/about/index.coffee

#-------------------------------------------------------------------------------
tmp:
	@-mkdir tmp

#-------------------------------------------------------------------------------
test: build
	@echo test TBD

#-------------------------------------------------------------------------------
vendor:
	@echo Downloading third party goop

    # installing npm modules

	@npm install

    # installing stuff for the browser

	@rm -rf vendor
	@mkdir vendor

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

VERSION_JQUERY        = 1.7.1
VERSION_JQUERY_UI     = 1.8.20

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
