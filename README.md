# Scripts used for comparative analysis of immune repertoire profiling technologies

First run ``Rscript compute_rearr_stats.R`` to get the data bundle, this should produce ``stats.RData`` and ``stats_dist.RData`` bundles. 
Note that ``milaboratory/mirutil`` library for computing RepSeq summary statistics should be installed using [devtools](https://cran.r-project.org/web/packages/devtools/index.html) for the script to run.
All corresponding analysis and figures can be produced by running ``rearrangement_statistics.Rmd`` R markdown notebook.