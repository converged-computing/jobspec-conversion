#!/bin/bash
#SBATCH --job-name=myMPI
#SBATCH --output=myMPI.o%j
#SBATCH --mail-user=normandin.utb@gmail.com
#SBATCH --mail-type=end
#SBATCH --nodes=11
#SBATCH --ntasks=11
#SBATCH --cpus-per-task=1
#SBATCH --time=01:30:00

export OMP_NUM_THREADS='24'

export OMP_NUM_THREADS=24
cd $WORK
ibrun tacc_affinity ./lda_matlab_pso settings.cfg data_snr9_0232.map pso.cfg 66 data_snr9_0232.pso
