#!/bin/bash
#FLUX: --job-name=chunky-squidward-3174
#FLUX: -t=14400
#FLUX: --urgency=16

module load r/4.1.2
Rscript /home/malosree/projects/def-gturecki/malosree/Finalized_downstream_analysis/Finalized_scripts/1.3_celltype_props_case_control.R
