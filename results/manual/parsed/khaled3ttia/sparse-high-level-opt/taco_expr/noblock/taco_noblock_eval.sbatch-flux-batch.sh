#!/bin/bash
#FLUX: --job-name=taco_noblocking
#FLUX: -n=128
#FLUX: --exclusive
#FLUX: --queue=disc
#FLUX: -t=172800
#FLUX: --urgency=16

cp /home/khaled/sparse-high-level-opt/taco_expr/run_tool_noblocking.sh /scratch/khaled/dask_out
echo "Starting Apptainer Container..."
apptainer exec --bind /scratch/khaled/dask_out:/data/ taco_py_latest.sif /data/run_tool_noblocking.sh /data/ /data/taco_noblock.csv 10 
echo "CPU SPEC"
lscpu
