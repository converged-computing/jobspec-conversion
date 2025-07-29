#!/bin/bash
#SBATCH --job-name=S2
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --time=02:24:00
#SBATCH --array=1-22

export R_LIBS_USER='$HOME/R-3.6.1-MKL'

module purge
module load gcc/8.2.0-fasrc01 openmpi/3.1.1-fasrc01
module load intel-mkl/2017.2.174-fasrc01
module load R/3.6.1-fasrc01
export R_LIBS_USER=$HOME/R-3.6.1-MKL
echo $R_LIBS_USER
/n/home05/zilinli/R-3.6.1/bin/Rscript --slave --no-restore --no-save Annotate.R ${SLURM_ARRAY_TASK_ID} > out"${SLURM_ARRAY_TASK_ID}".Rout
