#!/bin/bash
#SBATCH --job-name=JNAME
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60GB
#SBATCH --time=1-12:00:00
#SBATCH --constraint=broadwell

cd $SLURM_SUBMIT_DIR
imodule load icc_17-impi_2017
module load cuda/9.1.85.3
source /gscratch/pfaendtner/sarah/codes/gromacs18.3/gromacs-2018.3/bin/bin/GMXRC
source /gscratch/pfaendtner/jpfaendt/codes/plumed2/sourceme.sh
gmx_mpi mdrun -plumed plumed.dat -cpi -append -cpt 1 &>log.txt
exit 0
