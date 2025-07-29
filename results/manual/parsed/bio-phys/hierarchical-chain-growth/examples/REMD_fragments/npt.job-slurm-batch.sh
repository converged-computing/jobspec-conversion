#!/bin/bash
#SBATCH --job-name=name
#SBATCH --output=./tjob.out.%j
#SBATCH --error=./tjob.err.%j
#SBATCH --mail-user=<userid>@rzg.mpg.de
#SBATCH --mail-type=none
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=9
#SBATCH --mem=50000
#SBATCH --time=04:00:00
#SBATCH --partition=s.phys
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=./

module load intel/19.1.3
module load impi/2019.9
module load gromacs/2019.6
sys=$1
srun gmx mdrun -v -deffnm $sys"_npt"
