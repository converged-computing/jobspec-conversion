#!/bin/bash
#FLUX: --job-name=v2lr-auto-vscode
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --urgency=16

path="./output/v2lr/v2lr-"
j=$SLURM_JOB_ID
original_filename="${path}${j}.out"
new_filename="${path}${1}.out"
mv "$original_filename" "$new_filename"
module purge
module load miniconda/3
conda activate eit
echo $j
echo $1
echo $2
python -u v2lr.py $1
