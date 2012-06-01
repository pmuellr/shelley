# Licensed under the Tumbolia Public License. See footer for details.

PWD = $(shell pwd)
BWD = $(shell basename $(PWD))

buildAll:
	@echo "--------> building $(BWD)"
	@cd basic; make

buildOne:

	@echo "------------> building $(BWD)"

	@../../node_modules/.bin/coffee --compile *.coffee

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
