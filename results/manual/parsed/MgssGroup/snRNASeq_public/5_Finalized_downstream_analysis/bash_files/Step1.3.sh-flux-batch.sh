#!/bin/bash
#FLUX: --job-name=frigid-hippo-2841
#FLUX: -t=14400
#FLUX: --priority=16

module load r/4.1.2
Rscript /home/malosree/projects/def-gturecki/malosree/Finalized_downstream_analysis/Finalized_scripts/1.3_celltype_props_case_control.R
