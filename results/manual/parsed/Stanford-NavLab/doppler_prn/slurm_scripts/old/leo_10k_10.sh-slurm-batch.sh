#!/bin/bash
#SBATCH --job-name=leo_10k_10
#SBATCH --output=leo_10k_10%j.txt
#SBATCH --error=leo_10k_10%j.txt
#SBATCH --mail-user=yalan@stanford.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=8G
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1

export SLURM_SUBMIT_DIR='/home/groups/gracegao/prn_codes/doppler_prn'

module load python/3.9
export SLURM_SUBMIT_DIR=/home/groups/gracegao/prn_codes/doppler_prn
cd $SLURM_SUBMIT_DIR
lscpu
mkdir results
python3 run.py --s $SLURM_ARRAY_TASK_ID --f 29.6e3 --t 2e-7 --m 300 --n 10007 --gs 10 --maxit 1_000_000_000 --name "results/leo_10k_10" --log 35_000 --no-obj
