#!/bin/bash
#SBATCH --job-name=sweep
#SBATCH --output=slogs/sweep-%J.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
singularity exec ${OPENSPIEL_IMG} wandb agent ${WANDB_PROJECT}
