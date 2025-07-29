#!/bin/bash
#SBATCH --job-name=M1_H_sim
#SBATCH --output=out.txt
#SBATCH --error=error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=80
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=2-00:00:00

export HDF5_USE_FILE_LOCKING='FALSE'

START=$(date)
echo "Started running at $START."
export HDF5_USE_FILE_LOCKING=FALSE
unset DISPLAY
mpirun nrniv -mpi -python run_network.py config.json #srun
END=$(date)
echo "Done running simulation at $END"
TRIALNAME="baseline_135"
mkdir ../Analysis/simulation_results/"$TRIALNAME"
cp -a output/. ../Analysis/simulation_results/"$TRIALNAME"
cp -a ecp_tmp/. ../Analysis/simulation_results/"$TRIALNAME"
