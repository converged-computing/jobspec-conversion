#!/bin/bash
#SBATCH --job-name=M1_sim
#SBATCH --output=./stdout/M1_sim.o%j.out
#SBATCH --error=./stdout/M1_sim.e%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=50
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=2-00:00:00

export HDF5_USE_FILE_LOCKING='FALSE'

START=$(date)
echo "Started running at $START."
export HDF5_USE_FILE_LOCKING=FALSE
unset DISPLAY
mpirun ./components/mechanisms/x86_64/special -mpi -python run_network.py config_no_STP.json True # args: config file, whether use coreneuron
END=$(date)
echo "Done running simulation at $END"
TRIALNAME="baseline_r13_no_STP"
mkdir ../Analysis/simulation_results/"$TRIALNAME"
cp -a output/. ../Analysis/simulation_results/"$TRIALNAME"
cp -a ecp_tmp/. ../Analysis/simulation_results/"$TRIALNAME"
