#!/bin/bash
#SBATCH --job-name=compute_objectives
#SBATCH --output=compute_objectives%j.txt
#SBATCH --error=compute_objectives%j.txt
#SBATCH --mail-user=yalan@stanford.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=4G
#SBATCH --time=06:00:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1

export SLURM_SUBMIT_DIR='/home/groups/gracegao/prn_codes/doppler_prn'

module load python/3.9
export SLURM_SUBMIT_DIR=/home/groups/gracegao/prn_codes/doppler_prn
cd $SLURM_SUBMIT_DIR
lscpu
mkdir results
python3 compute_objectives.py
