#!/bin/bash
#FLUX: --job-name=combine-d1-output
#FLUX: --queue=standard
#FLUX: -t=18000
#FLUX: --priority=16

mkdir -p logs/slurm/
bash code/bash/family_d1_cat_csv_files.sh
