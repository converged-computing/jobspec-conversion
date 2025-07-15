#!/bin/bash
#FLUX: --job-name=fuzzy-hope-3787
#FLUX: -t=43200
#FLUX: --urgency=16

module load r/4.1.2
Rscript /home/malosree/projects/def-gturecki/malosree/Finalized_downstream_analysis/Finalized_scripts/3.4_spatial_reverse_label_transfer.R
