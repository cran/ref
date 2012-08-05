pkgname <- "ref"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('ref')

assign(".oldSearch", search(), pos = 'CheckExEnv')
cleanEx()
nameEx("HanoiTower")
### * HanoiTower

flush(stderr()); flush(stdout())

### Name: HanoiTower
### Title: application example for references
### Aliases: HanoiTower move.HanoiTower print.HanoiTower plot.HanoiTower
### Keywords: programming

### ** Examples

    HanoiTower(n=2)

 ## Not run: 
##D     # small memory examples
##D     HanoiTowerDemoBytes <- 0
##D     if (is.R())
##D       gc()
##D     HanoiTower(
##D       parameter.mode  = "reference"
##D     , recursion.mode  = "direct"
##D     , garbage = HanoiTowerDemoBytes
##D     )
##D     if (is.R())
##D       gc()
##D     HanoiTower(
##D       parameter.mode  = "reference"
##D     , recursion.mode  = "recall"
##D     , garbage = HanoiTowerDemoBytes
##D     )
##D     if (is.R())
##D       gc()
##D     HanoiTower(
##D       parameter.mode  = "value"
##D     , recursion.mode  = "direct"
##D     , garbage = HanoiTowerDemoBytes
##D     )
##D     if (is.R())
##D       gc()
##D     HanoiTower(
##D       parameter.mode  = "value"
##D     , recursion.mode  = "recall"
##D     , garbage = HanoiTowerDemoBytes
##D     )
##D     rm(HanoiTowerDemoBytes)
##D 
##D     # big memory examples
##D     HanoiTowerDemoBytes <- 100000
##D     if (is.R())
##D       gc()
##D     HanoiTower(
##D       parameter.mode  = "reference"
##D     , recursion.mode  = "direct"
##D     , garbage = HanoiTowerDemoBytes
##D     )
##D     if (is.R())
##D       gc()
##D     HanoiTower(
##D       parameter.mode  = "reference"
##D     , recursion.mode  = "recall"
##D     , garbage = HanoiTowerDemoBytes
##D     )
##D     if (is.R())
##D       gc()
##D     HanoiTower(
##D       parameter.mode  = "value"
##D     , recursion.mode  = "direct"
##D     , garbage = HanoiTowerDemoBytes
##D     )
##D     if (is.R())
##D       gc()
##D     HanoiTower(
##D       parameter.mode  = "value"
##D     , recursion.mode  = "recall"
##D     , garbage = HanoiTowerDemoBytes
##D     )
##D     rm(HanoiTowerDemoBytes)
##D   
## End(Not run)



cleanEx()
nameEx("as.ref")
### * as.ref

flush(stderr()); flush(stdout())

### Name: as.ref
### Title: coercing to reference
### Aliases: as.ref
### Keywords: programming

### ** Examples

  v <- 1
  r <- as.ref(v)
  r
  deref(r)



cleanEx()
nameEx("deref")
### * deref

flush(stderr()); flush(stdout())

### Name: deref
### Title: dereferencing references
### Aliases: deref deref<-
### Keywords: programming

### ** Examples

  # Simple usage example
  x <- cbind(1:5, 1:5)          # take some object
  rx <- as.ref(x)               # wrap it into a reference
  deref(rx)                     # read it through the reference
  deref(rx) <- rbind(1:5, 1:5)  # replace the object in the reference by another one
  deref(rx)[1, ]                # read part of the object
  deref(rx)[1, ] <- 5:1         # replace part of the object
  deref(rx)                     # see the change
  cat("For examples how to pass by references see the Performance test examples at the help pages\n")

 ## Not run: 
##D   ## Performance test examples showing actually passing by reference
##D   # define test size
##D   nmatrix <- 1000   # matrix size of nmatrix by nmatrix
##D   nloop   <- 10     # you might want to use less loops in S+, you might want more in R versions before 1.8
##D 
##D   # Performance test using ref
##D   t1 <- function(){ # outer function
##D     m <- matrix(nrow=nmatrix, ncol=nmatrix)
##D     a <- as.ref(m)
##D       t2(a)
##D     m[1,1]
##D   }
##D   # subsetting deref is slower (by factor 75 slower since R 1.8 compared to previous versions, and much, much slower in S+) ...
##D   t2 <- function(ref){ # inner function
##D     cat("timing", timing.wrapper(
##D       for(i in 1:nloop)
##D         deref(ref)[1,1] <- i
##D     ), "\n")
##D   }
##D   if (is.R())gc()
##D   t1()
##D   # ... than using substitute
##D   t2 <- function(ref){
##D     obj <- as.name(ref$name)
##D     loc <- ref$loc
##D     cat("timing", timing.wrapper(
##D       for(i in 1:nloop)
##D         eval(substitute(x[1,1] <- i, list(x=obj, i=i)), loc)
##D     ), "\n")
##D   }
##D   if (is.R())gc()
##D   t1()
##D 
##D 
##D   # Performance test using Object (R only)
##D   # see Henrik Bengtsson package(oo)
##D   Object <- function(){
##D     this <- list(env.=new.env());
##D     class(this) <- "Object";
##D     this;
##D   }
##D   "$.Object" <- function(this, name){
##D     get(name, envir=unclass(this)$env.);
##D   }
##D   "$<-.Object" <- function(this, name, value){
##D     assign(name, value, envir=unclass(this)$env.);
##D     this;
##D   }
##D   # outer function
##D   t1 <- function(){
##D     o <- Object()
##D     o$m <- matrix(nrow=nmatrix, ncol=nmatrix)
##D       t2(o)
##D     o$m[1,1]
##D   }
##D   # subsetting o$m is slower ...
##D   t2 <- function(o){
##D     cat("timing", timing.wrapper(
##D       for(i in 1:nloop)
##D         o$m[1,1] <- i
##D     ), "\n")
##D   }
##D   if (is.R())gc()
##D   t1()
##D   # ... than using substitute
##D   t2 <- function(o){
##D     env <- unclass(o)$env.
##D     cat("timing", timing.wrapper(
##D       for(i in 1:nloop)
##D         eval(substitute(m[1,1] <- i, list(i=i)), env)
##D     ), "\n")
##D   }
##D   if (is.R())gc()
##D   t1()
##D 
##D   
## End(Not run)



cleanEx()
nameEx("is.ref")
### * is.ref

flush(stderr()); flush(stdout())

### Name: is.ref
### Title: checking (for) references
### Aliases: is.ref exists.ref
### Keywords: programming

### ** Examples

  v <- 1
  good.r <- as.ref(v)
  bad.r <- ref("NonExistingObject")
  is.ref(v)
  is.ref(good.r)
  is.ref(bad.r)
  exists.ref(good.r)
  exists.ref(bad.r)



cleanEx()
nameEx("optimal.index")
### * optimal.index

flush(stderr()); flush(stdout())

### Name: optimal.index
### Title: creating standardized, memory optimized index for subsetting
### Aliases: optimal.index need.index posi.index
### Keywords: utilities manip

### ** Examples

  l <- letters
  names(l) <- letters
  stopifnot({i <- 1:3 ; identical(l[i], l[optimal.index(i, n=length(l))])})
  stopifnot({i <- -(4:26) ; identical(l[i], l[optimal.index(i, n=length(l))])})
  stopifnot({i <- c(rep(TRUE, 3), rep(FALSE, 23)) ; identical(l[i], l[optimal.index(i, n=length(l))])})
  stopifnot({i <- c("a", "b", "c"); identical(l[i], l[optimal.index(i, i.names=names(l))])})
  old.options <- options(show.error.messages=FALSE); stopifnot(inherits(try(optimal.index(c(1:3, 3), n=length(l))), "try-error")); options(old.options)
  stopifnot({i <- c(1:3, 3, NA);identical(l[i], l[optimal.index(i, n=length(l), strict=FALSE)])})
  stopifnot({i <- c(-(4:26), -26);identical(l[i], l[optimal.index(i, n=length(l), strict=FALSE)])})
  stopifnot({i <- c(rep(TRUE, 3), rep(FALSE, 23), TRUE, FALSE, NA);identical(l[i], l[optimal.index(i, n=length(l), strict=FALSE)])})
  stopifnot({i <- c("a", "b", "c", "a", NA);identical(l[i], l[optimal.index(i, i.names=names(l), strict=FALSE)])})
  rm(l)



cleanEx()
nameEx("ref")
### * ref

flush(stderr()); flush(stdout())

### Name: ref
### Title: creating references
### Aliases: ref print.ref
### Keywords: programming

### ** Examples

  v <- 1
  r <- ref("v")
  r
  deref(r)
  cat("For more examples see ?deref\n")



cleanEx()
nameEx("refdata")
### * refdata

flush(stderr()); flush(stdout())

### Name: refdata
### Title: subsettable reference to matrix or data.frame
### Aliases: refdata derefdata derefdata<- [.refdata [<-.refdata [[.refdata
###   [[<-.refdata $.refdata $<-.refdata dim.refdata dimnames.refdata
###   row.names.refdata names.refdata print.refdata
### Keywords: programming manip

### ** Examples


  ## Simple usage Example
  x <- cbind(1:5, 5:1)            # take a matrix or data frame
  rx <- refdata(x)                # wrap it into an refdata object
  rx                              # see the autoprinting
  rm(x)                           # delete original to save memory
  rx[]                            # extract all data
  rx[-1, ]                        # extract part of data
  rx2 <- rx[-1, , ref=TRUE]       # create refdata object referencing part of data (only index, no data is duplicated)
  rx2                             # compare autoprinting
  rx2[]                           # extract 'all' data
  rx2[-1, ]                       # extract part of (part of) data
  cat("for more examples look the help pages\n")

 ## Not run: 
##D   # Memory saving demos
##D   square.matrix.size <- 1000
##D   recursion.depth.limit <- 10
##D   non.referenced.matrix <- matrix(1:(square.matrix.size*square.matrix.size), nrow=square.matrix.size, ncol=square.matrix.size)
##D   rownames(non.referenced.matrix) <- paste("a", seq(length=square.matrix.size), sep="")
##D   colnames(non.referenced.matrix) <- paste("b", seq(length=square.matrix.size), sep="")
##D   referenced.matrix <- refdata(non.referenced.matrix)
##D   recurse.nonref <- function(m, depth.limit=10){
##D     x <- m[1,1]   # need read access here to create local copy
##D     gc()
##D     cat("depth.limit=", depth.limit, "  memory.size=", memsize.wrapper(), "\n", sep="")
##D     if (depth.limit)
##D       Recall(m[-1, -1, drop=FALSE], depth.limit=depth.limit-1)
##D     invisible()
##D   }
##D   recurse.ref <- function(m, depth.limit=10){
##D     x <- m[1,1]   # read access, otherwise nothing happens
##D     gc()
##D     cat("depth.limit=", depth.limit, "  memory.size=",  memsize.wrapper(), "\n", sep="")
##D     if (depth.limit)
##D       Recall(m[-1, -1, ref=TRUE], depth.limit=depth.limit-1)
##D     invisible()
##D   }
##D   gc()
##D   memsize.wrapper()
##D   recurse.ref(referenced.matrix, recursion.depth.limit)
##D   gc()
##D    memsize.wrapper()
##D   recurse.nonref(non.referenced.matrix, recursion.depth.limit)
##D   gc()
##D    memsize.wrapper()
##D   rm(recurse.nonref, recurse.ref, non.referenced.matrix, referenced.matrix, square.matrix.size, recursion.depth.limit)
##D   
## End(Not run)
  cat("for even more examples look at regression.test.refdata()\n")
  regression.test.refdata()  # testing correctness of refdata functionality



cleanEx()
nameEx("regression.test.refdata")
### * regression.test.refdata

flush(stderr()); flush(stdout())

### Name: regression.test.refdata
### Title: regression test for refdata
### Aliases: regression.test.refdata
### Keywords: internal

### ** Examples

  regression.test.refdata()



### * <FOOTER>
###
cat("Time elapsed: ", proc.time() - get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
