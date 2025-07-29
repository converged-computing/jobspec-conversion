#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --account=edu2304.intropdc
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

ml PDC/22.06
ml matlab/r2023a
echo "Script initiated at `date` on `hostname`"
matlab -nodisplay -nodesktop -nosplash spectral_serial.m your_matlab_program.out
echo "Script finished at `date` on `hostname`"
