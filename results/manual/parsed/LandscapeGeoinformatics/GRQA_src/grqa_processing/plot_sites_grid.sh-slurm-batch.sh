#!/bin/bash
#FLUX: --job-name=plot_sites_grid
#FLUX: --queue=amd
#FLUX: -t=3600
#FLUX: --urgency=16

cd /gpfs/terra/export/samba/gis/holgerv/river_quality/scripts/grqa_processing
module purge
module load python
source activate river_quality
~/.conda/envs/river_quality/bin/python plot_sites_grid.py
