### =========================================================================
### FileImporter objects
### -------------------------------------------------------------------------
###
### Imports a file. 
###

setRefClass("FileImporter",
            methods = list(
              import = function(x, ...) {
                notImplemented("import")
              }
              ))

### File parsing is the conversion of a file to an R object of
### some class.  The general paradigm is to have a function that
### requests a FileImporter for a particular File and result class. This
### involves retrieving the importer class corresponding to the Format
### of the File and the result class. The FileImporter is constructed,
### and the File is then passed to the 'import' method on the
### FileImporter.

FileImporter <- function(format, resultClass = defaultResultClass(format)) {
  format <- as(format, "FileFormat")
  importerGenerator(format, new(resultClass))$new()
}

setGeneric("importerGenerator",
           function(format, result, ...) standardGeneric("importerGenerator"))

setGeneric("import",
           function(file, format, result, ...) standardGeneric("import"))
