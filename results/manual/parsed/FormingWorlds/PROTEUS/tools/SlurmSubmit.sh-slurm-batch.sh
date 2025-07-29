#!/bin/bash
#SBATCH --job-name=Slurm_GridPROTEUS
#SBATCH --output=slurm_out.txt
#SBATCH --error=slurm_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=19
#SBATCH --mem=2000
#SBATCH --partition=priority-rp

echo "Running slurm dispatcher"
source ~/.bashrc
conda activate proteus
module load julia 
source PROTEUS.env
srun python tools/GridPROTEUS.py 
