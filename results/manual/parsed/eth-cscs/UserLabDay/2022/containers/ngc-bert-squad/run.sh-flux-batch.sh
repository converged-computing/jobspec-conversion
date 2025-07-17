#!/bin/bash
#FLUX: --job-name=bert-squad-finetune
#FLUX: -N=8
#FLUX: -c=12
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load daint-gpu
module load sarus
module load OpenMPI/4.1.2   # installed locally by the user
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
mpirun sarus run --mount=type=bind,source=$SCRATCH,destination=$SCRATCH \
             nvcr.io/nvidia/pytorch:22.08-py3 \
             bash -c '
             cd $SCRATCH/UserLabDay/2022/containers/ngc-bert-squad
             . deepspeed-env/bin/activate;
             python bert_squad_deepspeed_train.py --deepspeed_config ds_config.json'
