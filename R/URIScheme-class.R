### =========================================================================
### URIScheme objects
### -------------------------------------------------------------------------
###
### Base for a class-based enumeration representing URI schemes
###

setClass("URIScheme", contains = "VIRTUAL")

setClass("FileScheme", contains = "URIScheme")
setClass("HTTPScheme", contains = "URIScheme")
setClass("FTPScheme", contains = "URIScheme")

setClassUnion("RSchemes", c("FileScheme", "HTTPScheme", "FTPScheme"))
