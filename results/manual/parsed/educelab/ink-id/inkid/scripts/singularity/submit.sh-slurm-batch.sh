#!/bin/bash
#SBATCH --job-name=inkid
#SBATCH --account=gol_seales_uksr
#SBATCH --output=out/inkid_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

module load ccs/singularity
if [ -z "$SLURM_ARRAY_TASK_ID" ]; then
    time singularity run --nv --overlay inkid.overlay inkid.sif inkid-train-and-predict "$@"
else
    time singularity run --nv --overlay inkid.overlay inkid.sif inkid-train-and-predict "$@" --cross-validate-on $SLURM_ARRAY_TASK_ID
fi
