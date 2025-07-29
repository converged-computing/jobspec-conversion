#!/bin/bash
#SBATCH --job-name=structure_B
#SBATCH --mail-user=tje3676@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=3

module purge
source /scratch/work/courses/CHEM-GA-2671-2023fa/software/gromacs-2019.6-plumedSept2020/bin/GMXRC.bash.modules
gmx_mpi mdrun -s topolB.tpr -nsteps 10000000
