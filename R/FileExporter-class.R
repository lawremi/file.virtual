### =========================================================================
### FileExporter objects
### -------------------------------------------------------------------------
###
### Exports a file. 
###

### This is different from importing, because with importing, one may
### want to store the result class in a closure. Here, all information
### is known at export time. Thus, we have a simple export() generic.

setGeneric("export", function(x, dest, format, ...) standardGeneric("export"))
