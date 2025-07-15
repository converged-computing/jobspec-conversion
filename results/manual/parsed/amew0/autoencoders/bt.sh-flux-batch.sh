#!/bin/bash
#FLUX: --job-name=diff-auto-vscode
#FLUX: --queue=gpu
#FLUX: -t=3599
#FLUX: --priority=16

path="./output/img/bt-"
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
python -u bt.py
