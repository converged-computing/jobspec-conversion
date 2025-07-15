#!/bin/bash
#FLUX: --job-name=bert-squad-finetune
#FLUX: -N=8
#FLUX: -c=12
#FLUX: -t=3000
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load daint-gpu
module load sarus
module load OpenMPI/4.1.2
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
mpirun sarus run --tty --mount=type=bind,source=$SCRATCH,destination=$SCRATCH \
             nvcr.io/nvidia/pytorch:22.08-py3 \
             bash -c '
             cd $SCRATCH/bert-demo;
             . deepspeed-env/bin/activate;
             python 3_squad_bert_deepspeed.py --deepspeed_config ds_config.json'
