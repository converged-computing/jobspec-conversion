#!/bin/bash
#FLUX: --job-name=1_train_GS
#FLUX: -c=96
#FLUX: --queue=stsi
#FLUX: -t=2160000
#FLUX: --urgency=16

module purge
module load pytorch/1.7.1py38-cuda
module load samtools/1.10
module load R
echo -e "Work dir is $SLURM_SUBMIT_DIR"
echo -e "Train list is $train_list, GPU a100"
cd $SLURM_SUBMIT_DIR
bash 3_train_best_model.sh $train_list A100
