### =========================================================================
### FileParser objects
### -------------------------------------------------------------------------
###
### Parses a file. 
###

setRefClass("FileParser",
            methods = list(
              parse = function(x, ...) {
                notImplemented("parse")
              }
              ))

### File parsing is the conversion of a file to an R object of
### some class.  The general paradigm is to have a function that
### requests a FileParser for a particular File and result class. This
### involves retrieving the parser class corresponding to the Format
### of the File and the result class. The FileParser is constructed,
### and the File is then passed to the 'parse' method on the
### FileParser.

FileParser <- function(format, resultClass = defaultResultClass(format)) {
  format <- as(format, "FileFormat")
  parserGenerator(format, new(resultClass))$new()
}

setGeneric("parserGenerator",
           function(format, result, ...) standardGeneric("parserGenerator"))
