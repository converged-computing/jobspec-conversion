#!/bin/bash
#SBATCH --account=pppl
#SBATCH --mail-user=drsmith@pppl.gov
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --gres=gpu:4
#SBATCH --mem=240G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module load edgeml
module list
source "/scratch/gpfs/dsmith/miniconda/etc/profile.d/conda.sh"
conda activate tf
which conda
which python3
env | egrep "SLURM|HOST"
srun python3 hpo-create.py
