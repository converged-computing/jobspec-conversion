#!/bin/bash
#FLUX: --job-name=fat-banana-8297
#FLUX: -t=43200
#FLUX: --priority=16

module load r/4.1.2
Rscript /home/malosree/projects/def-gturecki/malosree/Finalized_downstream_analysis/Finalized_scripts/3.4_spatial_reverse_label_transfer.R
