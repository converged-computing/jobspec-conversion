#!/bin/bash
#FLUX: --job-name=rainbow-pot-7180
#FLUX: --priority=16

cd /gpfs/terra/export/samba/gis/holgerv/river_quality/scripts/grqa_processing
module purge
module load python
source activate river_quality
~/.conda/envs/river_quality/bin/python plot_hist_grid.py
