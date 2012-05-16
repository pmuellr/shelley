# Licensed under the Tumbolia Public License. See footer for details.

fs   = require "fs"
path = require "path"

nopt = require "nopt"
mime = require "mime"

PROGRAM = path.basename(process.argv[1])
Version = null
Options = {}

#-------------------------------------------------------------------------------
main = ->
    [command, args, Options] = parseCommandLine()
    
    # console.log "cmd: #{JSON.stringify(command)}"
    # console.log "args: #{JSON.stringify(args)}"
    # console.log "opts: #{JSON.stringify(options)}"

    help() if !command
    help() if Options.help
    help() if command == "help"
    
    printVersion() if Options.version
    
    if command == "bundle"
        commandBundle args
    else
        error "command not valid: '#{command}'"
        
#-------------------------------------------------------------------------------
commandBundle = (args) ->
    directoryName = args[0]
    error "no directory name specified for bundle command" if !directoryName
    
    directoryName = path.resolve(directoryName)

    if !path.existsSync directoryName
        error "directory does not exist: '#{args[0]}'"
        
    stat = fs.statSync(directoryName)
    if !stat.isDirectory()
        error "directory name is not a directory: '#{args[0]}'"
    
    outputFile  = Options.output || "./shelley-bundle.js"
    packageName = Options.package || path.basename(directoryName)
    
    logVerbose "generating package #{packageName} in file #{outputFile} from #{directoryName}"
    
    output = []
    bundleDirectory(packageName, directoryName, output)
    
    try
        fs.writeFileSync outputFile, output.join("\n")
    catch e
        error "error writing file #{outputFile}: #{e}"

#-------------------------------------------------------------------------------
bundleDirectory = ->

#-------------------------------------------------------------------------------
printVersion = ->
    console.log getVersion()
    process.exit()

#-------------------------------------------------------------------------------
parseCommandLine = ->
    knownOpts = 
        debug:   Boolean
        out:     String
        package: String
        verbose: Boolean
        version: Boolean
        help:    Boolean
        
    shortHands = 
        d:   ["--debug"]
        o:   ["--output"]
        p:   ["--package"]
        v:   ["--verbose"]
        V:   ["--version"]
        "?": ["--help"]
        
    parsed = nopt(knownOpts, shortHands, process.argv, 2)
    
    args    = parsed.argv.remain || []
    command = args.shift() || "help"
    options = parsed
    
    delete options.argv
    
    [command, args, options]

#-------------------------------------------------------------------------------
error = (message) ->
    message = "#{PROGRAM}: #{message}"
    console.error(message)
    process.exit(1)

#-------------------------------------------------------------------------------
log = (message) ->
    message = "#{PROGRAM}: #{message}"
    console.log(message)

#-------------------------------------------------------------------------------
logVerbose = (message) ->
    log(message) if Options.verbose

#-------------------------------------------------------------------------------
getVersion = () ->
    return Version if Version 

    packageJsonName  = path.join(path.dirname(fs.realpathSync(__filename)), '../package.json')

    json = fs.readFileSync(packageJsonName, 'utf8')
    values = JSON.parse(json)

    Version = values.version
    return Version

#-------------------------------------------------------------------------------
help = ->
    message = """
    bundles files in a directory for shelley
    
    usage: #{PROGRAM} option* command arguments*
    
    options:
       -d --debug       generate debuggable output
       -o --output      name of the output file
       -p --package     name of the package
       -v --verbose     be verbose
       -V --version     print the version
       -? --help        print this help
    
    commands:
    
       bundle <directory>
       
           Bundles all the files in <directory>.  The 
           <directory> parameter is required.
    
           The default package name is the basename of the 
           directory.
           
           The default output file is ./shelley-bundle.js.
"""

    console.log message
    process.exit()

#-------------------------------------------------------------------------------
main()

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
