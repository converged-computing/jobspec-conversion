#!/bin/bash
#SBATCH --output=snakelog.out
#SBATCH --error=snakelog.err
#SBATCH --mail-user=demetzp@crick.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32GB
#SBATCH --time=3-00:00:00
#SBATCH --partition=cpu

export WANDB_API_KEY='########'

ml Python/3.10.8-GCCcore-12.2.0-bare
ml Anaconda3/2023.03
source /camp/apps/eb/software/Anaconda/conda.env.sh
env_name=$(head -1 environement.yml | cut -d' ' -f2)
if conda info --envs | grep -q "$env_name"; then
    echo "Environment $env_name exists, updating..."
    conda env update -f environement.yml
else
    echo "Environment $env_name does not exist, creating..."
    conda env create -f environement.yml
fi
conda activate $env_name
export WANDB_API_KEY=########
cd inst/python/
snakemake --local-cores 1 -j 10000 \
     --slurm  --resources disk_mb=6000   --default-resources slurm_account=u_froehlichf slurm_partition=cpu
