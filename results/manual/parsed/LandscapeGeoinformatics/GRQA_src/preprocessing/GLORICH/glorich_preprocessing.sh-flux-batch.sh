#!/bin/bash
#FLUX: --job-name=astute-carrot-1143
#FLUX: --priority=16

ds_name="GLORICH"
cd /gpfs/terra/export/samba/gis/holgerv/river_quality/scripts/preprocessing/${ds_name}
module purge
module load python
source activate river_quality
~/.conda/envs/river_quality/bin/python glorich_preprocessing.py
