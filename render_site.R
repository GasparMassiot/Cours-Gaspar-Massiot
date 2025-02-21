# On créé le dossier du site au cas où (peut être pas nécessaire)
# dir.create(file.path(getwd(), "build"))

# render_site, va juste render index.Rmd normalement
rmarkdown::render_site(encoding = 'UTF-8')

# Pour render les fichiers Rmd des sous-dossiers
dirs <- dir('.', pattern = "^_[^(site)]")
filenames_rmd <- NULL
for (d_ in dirs){
  filenames_rmd <- c(filenames_rmd, list.files(d_, pattern = '.Rmd', full.names = TRUE, recursive = T))
}

for(f_ in filenames_rmd){
  if (length(grep("Husson", f_))==0){
    system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_cache'))
    system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_files'))
    rmarkdown::render(f_, knit_root_dir = getwd())
  }
}

dirs <- dir('.', pattern = "^_[^(site)]")
filenames_qmd <- NULL
for (d_ in dirs){
  filenames_qmd <- c(filenames_qmd, list.files(d_, pattern = '.qmd', full.names = TRUE, recursive = T))
}

for(f_ in filenames_qmd){
  if (length(grep("Husson", f_))==0){
    system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".qmd")}_cache'))
    system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".qmd")}_files'))
    rmarkdown::render(f_, knit_root_dir = getwd())
  }
}

# # On envoie dans le dossier du site, pour moi il se nomme build
# dirs <- dir('.', pattern = "^_[^(site)]", full.names = T)
# 
# for (d_ in dirs){
#   file.copy(d_, "build", recursive=TRUE)
#   print(d_)
#   print(list.files(d_))
#   print(list.files("build"))
# }
