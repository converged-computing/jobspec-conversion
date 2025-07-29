#!/bin/bash
#SBATCH --job-name=makeSingularity
#SBATCH --account=biol4559-aob2x
#SBATCH --output=/scratch/aob2x/compBio/logs/makeSingularity.%A_%a.out
#SBATCH --error=/scratch/aob2x/compBio/logs/makeSingularity.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

module load singularity
cd /project/biol4559-aob2x/singularity
singularity pull --disable-cache destv2.sif docker://jcbn/dest_v2.5:latest
