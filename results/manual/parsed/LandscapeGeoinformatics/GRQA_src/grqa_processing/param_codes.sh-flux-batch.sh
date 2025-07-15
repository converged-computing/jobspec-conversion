#!/bin/bash
#FLUX: --job-name=bloated-peanut-butter-4162
#FLUX: --priority=16

cd /gpfs/terra/export/samba/gis/holgerv/river_quality/scripts/grqa_processing
module purge
module load python
source activate river_quality
~/.conda/envs/river_quality/bin/python param_codes.py
