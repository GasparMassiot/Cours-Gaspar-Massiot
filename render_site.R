# On créé le dossier du site au cas où (peut être pas nécessaire)
system('mkdir -p build') 

# render_site, va juste render index.Rmd normalement
rmarkdown::render_site(encoding = 'UTF-8')

# Pour render les fichiers Rmd des sous-dossiers
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

# On envoie dans le dossier du site, pour moi il se nomme build
dirs <- dir('.', pattern = "^_[^(site)]", full.names = T)

for (d_ in dirs){
  system( glue::glue( 'cp -rf {d_} build/. '))
  print(d_)
  list.files(d_)
}
