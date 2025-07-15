#!/bin/bash
#FLUX: --job-name=combine-dn1-output
#FLUX: --queue=standard
#FLUX: -t=18000
#FLUX: --priority=16

mkdir -p logs/slurm/
bash code/bash/dn1_cat_csv_files.sh
