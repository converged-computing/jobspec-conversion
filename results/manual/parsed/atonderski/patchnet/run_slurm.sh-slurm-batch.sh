#!/bin/bash
#SBATCH --output=/dl_workspaces/%u/patchnet/logs/slurm-%j-run.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=1

singularity exec --bind /dl_workspaces/$USER:/workspace --bind /datasets:/datasets /dl_workspaces/$USER/2021-agp-spatiotemporal/singularity/pytorch21_06.sif bash -c "$@"
