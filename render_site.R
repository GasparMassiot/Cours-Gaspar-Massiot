rmarkdown::render_site(encoding = 'UTF-8')

dirs <- dir('.', pattern = "^_[^(site)]")
filenames <- NULL
for (d_ in dirs){
  filenames <- c(filenames, list.files(d_, pattern = '.Rmd', full.names = TRUE, recursive = T))
}

for(f_ in filenames){
  system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_cache'))
  system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_files'))
  rmarkdown::render(f_)
}
