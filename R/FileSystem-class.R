### =========================================================================
### FileSystem objects
### -------------------------------------------------------------------------
###
### The core of a VFS implementation, a factory for creating a File
### instance from a URI.
###

setRefClass("FileSystem",
            fields = list(
              supportedURISchemes = function(value) {
                notImplemented("supportedURISchemes")
              }
              ),
            methods = list(
              createFile = function(uri, ...) {
                notImplemented("createFile")
              }
              ), contains = "VIRTUAL")

supportedFileSystems <- function() {
  lapply(names(getClass("FileSystem")@subclasses), getRefClass)
}

### =========================================================================
### Default FileSystem implementation
### -------------------------------------------------------------------------
###
### Maps a URI scheme to a File implementation through S4 dispatch.
###

URISchemeFileSystem <- 
  setRefClass("URISchemeFileSystem",
              fields = list(
                supportedURISchemes = function(value) {
                  
                }
                ),
              methods = list(
                createFile = function(uri, ...) {
                  fileGenerator(uriScheme(uri))$new(uri, ...)
                }
                ), contains = "FileSystem")

DefaultFileSystem <- URISchemeFileSystem$new()

setGeneric("fileGenerator", function(x, ...) standardGeneric("fileGenerator"))

setMethod("fileGenerator", "RSchemes", function(x) RFile)
