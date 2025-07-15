#!/bin/bash
#FLUX: --job-name="nequip"
#FLUX: -n=2
#FLUX: -c=12
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module purge
module load daint-gpu
module load PyTorch
idx=$SLURM_ARRAY_TASK_ID
SCRIPT_DIR=/users/tayfurog/deepMOF_dev/nequip/prediction/
python $SCRIPT_DIR/calcFreeEwithNequip.py -extxyz_path vasp_opt_lowest_10_polymeric_24atoms.extxyz -idx $idx 
exit
