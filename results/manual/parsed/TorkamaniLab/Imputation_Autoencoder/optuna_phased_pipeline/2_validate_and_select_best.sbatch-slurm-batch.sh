#!/bin/bash
#SBATCH --job-name=2_validate_and_select_best
#SBATCH --output=%x.oe%j
#SBATCH --error=%x.oe%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=100G
#SBATCH --time=25-00:00:00

module load samtools
module load R
module load pytorch/1.9.0py38-cuda
cd $SLURM_SUBMIT_DIR
bash 2_validate_and_select_best.sh $mdir $input
