#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=102400
#SBATCH --time=04:00:00
#SBATCH --qos=commit-main
#SBATCH --exclusive
#SBATCH --array=1-6%6

cd /data/scratch/willow/FinchBenchmarks/graphs
source /afs/csail.mit.edu/u/w/willow/everyone/.bashrc
echo $SCRATCH
echo $JULIA_DEPOT_PATH
echo $JULIAUP_DEPOT_PATH
echo $PATH
echo $(pwd)
julia run_graphs.jl -d "yang${SLURM_ARRAY_TASK_ID}" -o "graphs_data_${SLURM_ARRAY_TASK_ID}.json"
