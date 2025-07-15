#!/bin/bash
#FLUX: --job-name=pdot_dataset1
#FLUX: -c=16
#FLUX: --priority=16

echo "Starting run.sh script at $(date)"
module load julia  # Load Julia module, if available 
julia /home/ymeng3/experiments/code/pdot_code_ans/test/dataset3.jl
