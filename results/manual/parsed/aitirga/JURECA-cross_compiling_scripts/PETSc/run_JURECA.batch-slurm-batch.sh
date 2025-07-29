#!/bin/bash
#SBATCH --account=jiek63
#SBATCH --output=mpi-out.%j
#SBATCH --error=mpi-err.%j
#SBATCH --nodes=20
#SBATCH --ntasks=1360
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --partition=booster
#SBATCH --constraint=ntasks-per-node=68

module --force purge
module load Architecture/KNL
module load intel-para
srun /p/project/cjiek63/jiek6304/JURECA_PFLOTRAN_280119/pflotran/src/pflotran/pflotran -pflotranin input_Permafrost.in
