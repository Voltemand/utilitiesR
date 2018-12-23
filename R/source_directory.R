source_directory <- function(dir, upto = NULL){
  # TODO check if all files are sourceable

  # TODO use file.path

  # check directory exists
  if (!file_test("-d", dir)) {
    stop(dir, " is not a directory")
  }

  # check for the existence of an options file
  options_path <- paste0(dir, "/options.txt")
  use_options <- TRUE

  if (!file_test("-f", options_path)){
    # warn
    cat("There is no options file so files will be sourced in lexical order",
        " and the upto argument will be ignored")
    use_options <- FALSE

  } else {
    # read the file (into character vector)
    options <- readLines(paste0(dir, "/options.txt"))
  }

  if (use_options == TRUE){
    # making large assumptions about the form of options

    if (!is.null(upto)){ # better way?

      if(!(upto %in% list.files(dir))){
        stop(upto, " is not a file that appears in the directory")
      }

      i <- 1
      file <- options[i]
      source(paste0(dir, "/", file))

      while(file != upto){ # edge case of last upto
        file <- options[i + 1]
        source(paste0(dir, "/", file))
      }

    } else {
      # source all the files in order
      for (file in options){
        source(paste0(dir, "/", file))
      }
    }

  } else {

    # no options so naively source all in dir
    files <- list.files(dir)
    for (file in files){
      source(paste0(dir, "/", file))
    }
  }
  cat("all sourced!")
}


