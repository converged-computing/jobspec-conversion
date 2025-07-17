#!/bin/bash
#FLUX: --job-name=combine-d0-output
#FLUX: --queue=standard
#FLUX: -t=18000
#FLUX: --urgency=16

mkdir -p logs/slurm/
bash code/bash/d0_cat_csv_files.sh
