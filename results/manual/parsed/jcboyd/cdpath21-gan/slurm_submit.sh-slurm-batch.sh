#!/bin/bash
#SBATCH --job-name=pathgan
#SBATCH --output=./outputs/%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=60000

module load cuda/10.0.130/intel-19.0.3.199
source activate $WORKDIR/miniconda3/envs/pytorch
python main.py ${SLURM_JOBID} ./config/config_camelyon.yml
python main.py ${SLURM_JOBID} ./config/config_crc.yml
