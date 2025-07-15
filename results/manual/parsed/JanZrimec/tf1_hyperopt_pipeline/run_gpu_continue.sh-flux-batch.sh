#!/bin/bash
#FLUX: --job-name=expressive-milkshake-8548
#FLUX: --priority=16

source $HOME/loadenv_gpu.sh
cd /c3se/users/zrimec/Vera/projects/DeepExpression/2019_2_22
snakemake -j 1 --latency-wait 22 --max-jobs-per-second 1 --forceall --resources gpu=200 mem_frac=160 > _run_hyperas_scerevisiae_l2.log  
