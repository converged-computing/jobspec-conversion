#!/bin/bash
#FLUX: --job-name=nerdy-parrot-9323
#FLUX: --exclusive
#FLUX: --queue=lanka-v3
#FLUX: --priority=16

cd /data/scratch/willow/FinchBenchmarks/graphs
source /afs/csail.mit.edu/u/w/willow/everyone/.bashrc
echo $SCRATCH
echo $JULIA_DEPOT_PATH
echo $JULIAUP_DEPOT_PATH
echo $PATH
echo $(pwd)
julia run_graphs.jl -d "yang${SLURM_ARRAY_TASK_ID}" -o "graphs_data_${SLURM_ARRAY_TASK_ID}.json"
