#!/bin/bash
#FLUX: --job-name=persnickety-chair-4422
#FLUX: --urgency=16

module purge
module load Python/3.7.0-intel-2018b
module load CUDA/10.1.105
V=(neural_filter neural_filter_ctx_setpen neural_filter_ctx neural_filter_setpen baseline_filter list_baseline \
list_neural)
LOC=(DE FI EE AT HR SE)
ID=SLURM_ARRAY_TASK_ID
echo "BULK, PL, LOCS are: "
echo $BULK
echo $PL
echo $LOCS
srun $USERAPPL/ve37/bin/python3 eunlg/bulk_generate.py -l en -o $BULK -v $PL -d cphi --locations ${LOC[$ID]} \
--verbose
