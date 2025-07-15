#!/bin/bash
#FLUX: --job-name=sticky-fork-6663
#FLUX: --urgency=16

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
