#!/bin/bash
#SBATCH --job-name=1_train_GS
#SBATCH --output=%x.oe%j
#SBATCH --error=%x.oe%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=96
#SBATCH --gres=gpu:a100:4
#SBATCH --mem=240G
#SBATCH --time=25-00:00:00
#SBATCH --partition=stsi

module purge
module load pytorch/1.7.1py38-cuda
module load samtools/1.10
module load R
echo -e "Work dir is $SLURM_SUBMIT_DIR"
echo -e "Train list is $train_list, GPU a100"
cd $SLURM_SUBMIT_DIR
bash 3_train_best_model.sh $train_list A100
