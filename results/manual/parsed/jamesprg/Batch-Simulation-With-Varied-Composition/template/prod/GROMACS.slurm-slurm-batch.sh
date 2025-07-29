#!/bin/bash
#SBATCH --job-name=NAME
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120GB
#SBATCH --time=1-12:00:00

cd $SLURM_SUBMIT_DIR
imodule load icc_17-impi_2017
module load cuda/9.1.85.3
source /gscratch/pfaendtner/sarah/codes/gromacs18.3/gromacs-2018.3/bin/bin/GMXRC
gmx_mpi mdrun -cpi -append -cpt 1 &>log.txt
exit 0
