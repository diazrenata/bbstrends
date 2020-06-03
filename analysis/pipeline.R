library(MATSS)
library(drake)
library(bbstrends)

## include the functions in packages as dependencies
#  - this is to help Drake recognize that targets need to be rebuilt if the
#    functions have changed
expose_imports(MATSS)
expose_imports(bbstrends)

## a Drake plan for creating the datasets
#  - these are the default options, which don't include downloaded datasets
datasets <- build_bbs_datasets_plan()

datasets <- datasets[1:500,]

datasets <- build_size_datasets_plan(datasets_plan = datasets)


methods <- drake::drake_plan(
  sv = target(get_sv_ts(bbs_dat),
                transform = map(bbs_dat = !!rlang::syms(datasets$target))),
  lin = target(linear_trend(sv),
               transform = map(sv)),
  all_lin = target(dplyr::bind_rows(lin),
                   transform = combine(lin))#,
  # pop_lin = target(linear_trend_populations(bbs_dat),
  #                  transform = map(bbs_dat = !!rlang::syms(datasets$target [ which(!grepl("meane", datasets$target))]))),
  # all_pop_lin = target(dplyr::bind_rows(pop_lin),
  #                      transform = combine(pop_lin))
)

## a Drake plan for the Rmarkdown report
#  - we use `knitr_in()`
reports <- drake_plan(
  report = rmarkdown::render(
    knitr_in("analysis/report.Rmd"),
    output_file("analysis/report.md")
  )
)


## The full workflow
workflow <- dplyr::bind_rows(
  datasets,
  methods#,
 # reports
)

## Visualize how the targets depend on one another
if (interactive())
{
  config <- drake_config(workflow)
  sankey_drake_graph(config, build_times = "none", targets_only = TRUE)  # requires "networkD3" package
  vis_drake_graph(config, build_times = "none", targets_only = TRUE)     # requires "visNetwork" package
}

## Run the workflow
make(workflow)
