# Supplemental Folder 1

Contains analysis of evolutionary rates used in [Evolution of mechanisms that
control mating in *Drosophila*
males](https://www.ncbi.nlm.nih.gov/pubmed/31141679/)[^1]

[^1]: Ahmed, O.M., Avila-Herrera, A., Tun, K.M., Serpa, P.H., Peng, J.,
  Parthasarathy, S., Knapp, J.-M., Stern, D.L., Davis, G.W., Pollard, K.S.,
  Shah, N.M. (2019). Evolution of Mechanisms that Control Mating in Drosophila
  Males.  Cell Reports 27, 2527-2536.e4. doi:
  <https://doi.org/10.1016/j.celrep.2019.04.104>

## Main files

- `methods.Rmd`: RMarkdown to run PHAST, generates `methods.html`. Render this
  one first
- `figs.Rmd`: RMarkdown to generate figures and summary statistics, generates
  `figs.html`.

Example: `R --slave --vanilla -e 'rmarkdown::render("methods.Rmd")'`

## Funding

- Gladstone Institutes
- This work was produced in part under the auspices of the U.S. Department of
  Energy by Lawrence Livermore National Laboratory under Contract
  DE-AC52-07NA27344

## License

This code is licensed under the GNU GPLv3 License

## Release

LLNL-CODE-773163

