### =========================================================================
### File objects
### -------------------------------------------------------------------------
###
### Wrapper around a URI that yields its children, if any, and
### generates connections for I/O. This is the core of the VFS.
### 

### The File class is vectorized over multiple paths. This obviously
### flows from the need to manipulate multiple files at once. Most of
### the R file API is vectorized for this reason.

### File is naturally a reference class, as it represents an external
### resource, although it is otherwise immutable. The reference class
### fields and methods should generally not be called by the
### user. They merely provide a clean separation between the public
### wrappers and the implementation.

### BIG TODO: monitoring, mounting, asynchronous access
### The above would be easy to achieve with GIO via RGtk2

setRefClass("File",
            fields = list(
              uri = function(value) {
                notImplemented("uri")
              },
              displayName = function(value) {
                basename(uri)
              },
              children = function(value) {
                notImplemented("children")
              }, 
              parent = function(value) {
                notImplemented("parent")
              },
              info = function(value) { # like that returned by file.info()
                notImplemented("info")
              },
              metadata = function(value) { # high-level info about file
                notImplemented("metadata")
              },
              format = function(value) {
### TODO: memoize
                readOnly("format")
                formats <- knownFileFormats()
                for (format in formats) {
                  if (hasFormat(.self, format))
                    return(format)
                }
                NULL
              }
              ),
            methods = list(
              ## returned connections must implement the R connections API
              ## i.e., they should extend 'connection'
### Q: are open() and parse() better accepting scalars?  For open(),
### opening files consumes finite resources; usually need to
### explicitly iterate over each file anyway. When dealing with a
### single file, it is a pain to deal with the returned list. For
### parsing, it is more convenient, because returned list is typically
### homogeneous and can be cast to something useful.
### Solutions:
### - Require a single file
### - By default, drop single parse result to scalar
### - Just always return a list like strsplit()     
### We should take the second option for the open() wrapper, so that
### some sort of conformance is preserved. Everything else returns a list.
              open = function(open = "r", blocking = TRUE, ...) {
                notImplemented("open")
              },
              create = function() {
                notImplemented("create")
              },
              makeDirectory = function() {
                notImplemented("makeDirectory")
              },
              remove = function() {
                notImplemented("remove")
              },
              move = function(to) {
                notImplemented("move")
              },
              copy = function(to) {
                notImplemented("copy")
              },
              symlink = function(to) {
                notImplemented("symlink")
              },
              import = function(resultClass = defaultResultClass(format), ...) {
                FileImporter(format, resultClass)$import(.self, ...)
              },
              export = function(object, ...) {
                FileExporter(format)$export(object, .self, ...)
              }
              )
            )

### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### Constructor.
###

File <- function(uri, ..., fileSystem = DefaultFileSystem) {
  fileSystem$createFile(uri, ...)
}

setAs("character", "File", function(from) File(from))

### The rest of this file consists of compatibility wrappers

### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### URI manipulation.
###

setMethod("basename", "File", function(path) {
})

setMethod("dirname", "File", function(path) {
})

setMethod("normalizePath", "File",
          function(path, winslash = "\\", mustWork = NA) {
            
          })

## TODO: path, scheme

### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### Navigation.
###

setMethod("list.files", "File",
          function(path, pattern = NULL, all.files = FALSE,
                   full.names = FALSE, recursive = FALSE,
                   ignore.case = FALSE, include.dirs = FALSE)
          {
          })

setMethod("list.dirs", "File", function(path, full.names = TRUE) {
})

### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### File operation wrappers.
###

setMethod("file.create", "File", function(..., showWarnings = TRUE) {
})

setMethod("dir.create", "File",
          function(path, showWarnings = TRUE, recursive = FALSE, mode = "0777")
          {
          })

setMethod("file.exists", "File", function(...) {
})

setMethod("file.remove", "File", function(...) {
})

setMethod("unlink", "File", function(x, recursive = TRUE, force = FALSE) {
})

setMethod("file.rename", c("File", "File"), function(from, to) {
})

setMethod("file.append", c("File", "File"), function(file1, file2) {
})

setMethod("file.copy", c("File", "File"),
          function(from, to, overwrite = recursive, recursive = FALSE,
                   copy.mode = TRUE)
          {
          })

setMethod("file.symlink", c("File", "File"), function(from, to) {
})

## setMethod("file.link", c("File", "File"), function(from, to) {
## })

### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### Information
###

setMethod("file.access", "File", function(names, mode = 0) {
})

setMethod("file.info", "File", function(...) {
})

setMethod("Sys.readlink", "File", function(paths) {
})

### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### Show/edit
###

setMethod("file.show", "File",
          function(..., header = rep("", nfiles), title = "R Information",
                   delete.file = FALSE, pager = getOption("pager"),
                   encoding = "")
          {
          })

setMethod("file.edit", "File",
          function(..., title = file, editor = getOption("editor"),
                   fileEncoding = "")
          {
          })

