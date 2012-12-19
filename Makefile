# Licensed under the Tumbolia Public License. See footer for details.

.PHONY: build test vendor

#-------------------------------------------------------------------------------
all: help

#-------------------------------------------------------------------------------
clean:
	@rm -rf tmp

#-------------------------------------------------------------------------------
build: tmp build-shelley

#-------------------------------------------------------------------------------
build-shelley:
	@echo "--------> building shelley.js"

	@rm -rf tmp

	@-mkdir -p   tmp/shelley
	@cp -R lib/* tmp/shelley

	@echo "require('./shelley')" > tmp/index.js

    # run browserify
	@echo "running browserify (rel)"
	@node_modules/.bin/browserify tmp/index.js \
        --verbose \
        --alias 'shelley:/shelley' \
        --outfile shelley.js

    # run browserify
	@echo "running browserify (dev)"
	@node_modules/.bin/browserify tmp/index.js \
        --debug \
        --alias 'shelley:/shelley' \
        --outfile shelley-debug.js

	@touch tmp/build-done.txt

#-------------------------------------------------------------------------------
tmp:
	@-mkdir tmp

#-------------------------------------------------------------------------------
vendor: vendor-init vendor-jquery-ui

#-------------------------------------------------------------------------------
vendor-init:
	@echo Downloading third party goop

    # installing npm modules

	@npm install

    # installing stuff for the browser

	@rm -rf vendor
	@mkdir  vendor

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

VERSION_JQUERY        = 1.8.2
VERSION_JQUERY_UI     = 1.9.0

#-------------------------------------------------------------------------------
help:
	@echo "targets available:"
	@echo ""
	@echo "    build  - build the products"
	@echo "    vendor - get the 3rd party files"
	@echo "    clean  - clean up transient stuff"

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
