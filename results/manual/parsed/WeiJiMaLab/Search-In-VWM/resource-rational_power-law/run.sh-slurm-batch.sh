#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=fminbnd_nll_std__%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=3-03:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load matlab/R2013a
if [[ ! -z "$SLURM_ARRAY_TASK_ID" ]]; then
        IID=${SLURM_ARRAY_TASK_ID}
fi
cat<<EOF | matlab -nodisplay
addpath('/jukebox/scratch/aditis/bads-master/');
optim_normative_sim_pow($IID)
EOF
