#!/bin/bash
#FLUX: --job-name=bumfuzzled-train-7680
#FLUX: --priority=16

module load gcc/10.2 pcre2/10.35 intel/2020.2 texlive/2018 R/3.5.2
R CMD BATCH --quiet --no-restore --no-save delete_files.R test_delete.out
