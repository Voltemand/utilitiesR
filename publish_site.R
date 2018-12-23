# Need to ensure _site.yml is correct

publish_site <- function(dir = "./docs", debug = FALSE){
  repo <- git2r::repository(getwd())

  cat("Rendering... ")
  rmarkdown::render_site(quiet = !debug)
  cat(cli::symbol$tick, "\n")

  cat("Adding files.. ")
  for (file in c("_site.yml", list.files(dir))){
     git2r::add(repo, here::here("docs", file))
  }
  cat(cli::symbol$tick, "\n")

  cat("Commiting... ")
  tryCatch(
    git2r::commit(repo, "build site", all = all),
    error = function(e) {
      stop("commit failed - make sure some files were added or changed")
      })

  cat(cli::symbol$tick, "\n")

  cat("Pushing to github... ")
  #git2r::push(repo)
  system("git push origin master", ignore.stderr = TRUE)
  cat(cli::symbol$tick, "\n")

  cat(crayon::bold("Done!"))
}
