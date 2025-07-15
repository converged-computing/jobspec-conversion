#!/bin/bash
#FLUX: --job-name=tart-truffle-0177
#FLUX: --priority=16

module load spack/spack-0.18.1
spack load r@4.2.1 r-sf
met=master.file.fst.txt
n="${SLURM_ARRAY_TASK_ID}"
echo $n
Rscript \
--vanilla \
1.0.explore_window_analyses.R $n
date
echo "done"
