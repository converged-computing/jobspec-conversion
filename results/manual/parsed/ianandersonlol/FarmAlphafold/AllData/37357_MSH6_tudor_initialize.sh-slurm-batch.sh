#!/bin/bash
#SBATCH --job-name=MSH6_tudor
#SBATCH --output=/home/icanders/slurm-log/37357_output.txt
#SBATCH --error=/home/icanders/slurm-log/37357_errors.txt
#SBATCH --mail-user=icanderson@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=128G
#SBATCH --time=2-00:00:00

set -e
set -u
module load spack/singularity/3.8.3
singularity instance start --nv -B /home/icanders/alphafoldDownload /home/icanders/alphafold_singularity/alphafold.sif bash
singularity exec instance://bash ~/37357_MSH6_tudor.sh
