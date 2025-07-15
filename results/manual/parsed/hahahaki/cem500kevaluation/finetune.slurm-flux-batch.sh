#!/bin/bash
#FLUX: --job-name=finetunemocounet
#FLUX: -c=6
#FLUX: -t=2400
#FLUX: --priority=16

source /home/codee/miniconda3/etc/profile.d/conda.sh
conda activate base
log_dir="/home/codee/scratch/sourcecode/cem-dataset/evaluation/finetunesave"
echo log_dir : `pwd`/$log_dir
mkdir -p `pwd`/$log_dir
echo "$SLURM_NODEID Launching python script"
/home/codee/miniconda3/bin/python /home/codee/scratch/sourcecode/cem-dataset/evaluation/finetune.py > $log_dir/mocofinetune1.8
echo "finetune finished"
