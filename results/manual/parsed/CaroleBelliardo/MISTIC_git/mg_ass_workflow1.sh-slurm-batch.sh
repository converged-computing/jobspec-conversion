#!/bin/bash
#SBATCH --job-name=mg
#SBATCH --output=slurm-mg-%j.out
#SBATCH --error=slurm-mg-%j.err
#SBATCH --mail-user=carole.belliardo@inrae.fr
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=64G

module load singularity/3.5.3
