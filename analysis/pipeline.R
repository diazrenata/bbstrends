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

datasets <- datasets[1:100,]

size_files <- list.files("C:/Users/diaz.renata/Documents/GitHub/BBSsize/analysis/isd_data/", full.names = T)

energy_files <- size_files[grepl(size_files, pattern = "energy")]
size_files <- size_files[grepl(size_files, pattern = "size_bb")]

new_files <- c(energy_files, size_files)

new_file_names <- substr(new_files, 65, nchar(new_files) - 4)


new_datasets <- drake::drake_plan(
  dat = target(readRDS(file = a_file),
               transform = map(
                 a_file = !!new_files,
                 .id = !!new_file_names
               )#,
               #trigger = trigger(condition = TRUE)
               )
)

new_datasets$target <- new_file_names


datasets <- dplyr::bind_rows(datasets, new_datasets)

## a Drake plan that defines the methods
methods <- drake::drake_plan(
  sv = target(get_sv_ts(bbs_dat),
                transform = map(bbs_dat = !!rlang::syms(datasets$target))),
  lin = target(linear_trend(sv),
               transform = map(sv)),
  all_lin = target(dplyr::bind_rows(lin),
                   transform = combine(lin)),
  pop_lin = target(linear_trend_populations(bbs_dat),
                   transform = map(bbs_dat = !!rlang::syms(datasets$target))),
  all_pop_lin = target(dplyr::bind_rows(pop_lin),
                       transform = combine(pop_lin))
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
