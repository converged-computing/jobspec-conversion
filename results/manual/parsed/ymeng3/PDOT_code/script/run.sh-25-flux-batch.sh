#!/bin/bash
#FLUX: --job-name=pdot_dataset1
#FLUX: -c=16
#FLUX: --priority=16

module load julia  # Load Julia module, if available 
julia /home/ymeng3/experiments/code/pdot_code2/test/dataset2.jl
