#!/bin/bash
#SBATCH --job-name=3_train_custom_best_model_titan
#SBATCH --output=%x.oe%j
#SBATCH --error=%x.oe%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:titanv:2
#SBATCH --time=25-00:00:00
#SBATCH --exclusive

module purge
module load samtools/1.10
module load R
module load python/3.8.3
module load cuda/10.2
echo -e "Work dir is $SLURM_SUBMIT_DIR"
echo -e "Train list is $train_list, GPU titanv"
cd $SLURM_SUBMIT_DIR
bash 3_train_custom_best_model.sh $train_list TITAN
