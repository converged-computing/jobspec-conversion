#!/bin/bash
#FLUX: --job-name=combine-d0-output
#FLUX: --queue=standard
#FLUX: -t=18000
#FLUX: --priority=16

mkdir -p logs/slurm/
bash code/bash/d0_cat_csv_files.sh
