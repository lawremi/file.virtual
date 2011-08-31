### =========================================================================
### FileFormat objects
### -------------------------------------------------------------------------
###
### Base class for an enumeration upon which we can dispatch for parsing
###

### How does the dispatching work for parsing? A parser should
### probably NOT depend on the File or connection implementation. Just
### the format. However, many R import API's operate on URL's, not R
### connections. These handle some set of URL schemes. To accommodate
### URL-based importers, we must also dispatch on the scheme. Practically
### speaking, though, many formats only have one parser in R,
### so there is unlikely to be contention between multiple parsers
### that could be resolved by URI scheme support. So we pass for now.

setClass("FileFormat", contains = "VIRTUAL")

### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### Format lookup.
###

## How to map a File to a Format? The most flexible way would be to
## ask each Format whether it applies to a File. This could involve
## path parsing or even data sniffing.

setGeneric("hasFormat",
           function(x, format, ...) standardGeneric("hasFormat"))

## By default, we just check the extension
setMethod("hasFormat", c("File", "FileFormat"),
          function(x, format) {
            extension <- gsub(".*\\.", "", x$uri)
            extensionClass <- .formatClassFromExtension(extension)
            is(format, extensionClass)
          })

### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### Static accessors.
###

setGeneric("defaultResultClass",
           function(x, ...) standardGeneric("defaultResultClass"))

### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### Coercion.
###

.formatClassFromExtension <- function(extension) {
  paste(toupper(extension), "Format", sep = "")
}

setAs("character", "FileFormat", function(from) {
  new(.formatClassFromExtension(from))
})

### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### Utilities.
###

supportedFileFormats <- function() {
  lapply(getClass("FileFormat")@subclasses, new)
}
