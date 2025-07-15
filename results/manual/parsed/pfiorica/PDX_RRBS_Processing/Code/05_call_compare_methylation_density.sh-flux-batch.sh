#!/bin/bash
#FLUX: --job-name=compare_methylation_Density_plots
#FLUX: --queue=general-compute --qos=general-compute
#FLUX: -t=43200
#FLUX: --priority=16

module load R/3.5.1
cd /projects/rpci/joyceohm/pnfioric/PDX_RRBS_Processing/Code
Rscript 05_Compare_Methylation_Density.R
