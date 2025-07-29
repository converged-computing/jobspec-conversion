#!/bin/bash
#SBATCH --job-name=M1_H_base
#SBATCH --output=out_baseline.txt
#SBATCH --error=error_baseline.txt
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=2-00:00:00

START=$(date)
echo "Started running at $START."
mpirun nrniv -mpi -python run_network.py simulation_config_baseline.json #srun
END=$(date)
echo "Done running simulation at $END"
