# Supplemental Folder 1

Contains analysis of evolutionary rates used in [Evolution of mechanisms that
control mating in *Drosophila*
males [^1]](https://www.biorxiv.org/content/early/2017/08/16/177337)

## Main files

- `methods.Rmd`: RMarkdown to run PHAST, generates `methods.html`. Render this
  one first
- `figs.Rmd`: RMarkdown to generate figures and summary statistics, generates
  `figs.html`.

Example: `R --slave --vanilla -e 'rmarkdown::render("methods.Rmd")'`

[^1]:  *Evolution of mechanisms that control mating in* Drosophila *males*
  Osama M. Ahmed, Nirao M. Shah, David L. Stern, Graeme W. Davis, Katherine S.
  Pollard, Srinivas Parthasarathy, Aram Avila-Herrera, Khin May Tun, Paula H.
  Serpa, Justin Peng, Jon-Michael Knapp bioRxiv 177337; doi:
  <https://doi.org/10.1101/177337>


