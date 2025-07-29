#!/bin/bash
#SBATCH --job-name=taco_noblocking
#SBATCH --output=taco_noblocking_%J_stdout.txt
#SBATCH --error=taco_noblocking_%J_stderr.txt
#SBATCH --mail-user=khaled.abdelaal@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=256G
#SBATCH --time=2-00:00:00
#SBATCH --exclusive
#SBATCH --chdir=/home/khaled/

cp /home/khaled/sparse-high-level-opt/taco_expr/run_tool_noblocking.sh /scratch/khaled/dask_out
echo "Starting Apptainer Container..."
apptainer exec --bind /scratch/khaled/dask_out:/data/ taco_py_latest.sif /data/run_tool_noblocking.sh /data/ /data/taco_noblock.csv 10 
echo "CPU SPEC"
lscpu
