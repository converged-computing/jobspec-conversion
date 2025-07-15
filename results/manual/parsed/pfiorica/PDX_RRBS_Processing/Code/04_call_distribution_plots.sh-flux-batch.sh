#!/bin/bash
#FLUX: --job-name=Distribution_plots
#FLUX: --queue=general-compute --qos=general-compute
#FLUX: -t=43200
#FLUX: --priority=16

module load R/3.5.1
cd /projects/rpci/joyceohm/pnfioric/PDX_RRBS_Processing/Code
Rscript 04_distribution_plots_for_samples.R
