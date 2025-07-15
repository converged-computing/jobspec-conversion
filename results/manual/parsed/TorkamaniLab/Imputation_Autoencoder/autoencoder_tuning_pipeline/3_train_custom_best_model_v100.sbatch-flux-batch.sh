#!/bin/bash
#FLUX: --job-name=3_train_custom_best_model_v100
#FLUX: --exclusive
#FLUX: --queue=stsi
#FLUX: -t=2160000
#FLUX: --priority=16

module purge
module load python/3.8.3
module load cuda/10.2
module load samtools/1.10
module load R
echo -e "Work dir is $SLURM_SUBMIT_DIR"
echo -e "Train list is $train_list, GPU v100"
cd $SLURM_SUBMIT_DIR
bash 3_train_custom_best_model.sh $train_list V100
