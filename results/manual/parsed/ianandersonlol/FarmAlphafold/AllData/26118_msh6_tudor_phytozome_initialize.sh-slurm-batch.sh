#!/bin/bash
#SBATCH --job-name=msh6_tudor_phytozome
#SBATCH --output=/home/icanders/slurm-log/26118_output.txt
#SBATCH --error=/home/icanders/slurm-log/26118_errors.txt
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
singularity instance start --nv -B /home/haryu/alphafoldDownload /home/icanders/alphafold_singularity/alphafold.sif bash
singularity exec instance://bash ~/26118_msh6_tudor_phytozome.sh
