#!/bin/bash
#FLUX: --job-name=compare_methylation_change_plots
#FLUX: --queue=general-compute
#FLUX: -t=86400
#FLUX: --urgency=16

module load R/3.5.1
cd /projects/rpci/joyceohm/pnfioric/PDX_RRBS_Processing/Code
Rscript 06_Compare_Methylation_Change.R
