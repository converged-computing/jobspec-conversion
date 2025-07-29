#!/bin/bash
#SBATCH --job-name=M1_H_short
#SBATCH --output=out_short.txt
#SBATCH --error=error_short.txt
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=2-00:00:00

START=$(date)
echo "Started running at $START."
mpirun nrniv -mpi -python run_network.py simulation_config_short.json #srun
END=$(date)
echo "Done running simulation at $END"
