#!/bin/bash
#FLUX: --job-name=confused-snack-7079
#FLUX: -N=64
#FLUX: -n=64
#FLUX: --queue=broadwell
#FLUX: -t=60
#FLUX: --urgency=16

export KMP_BLOCKTIME='0'
export KMP_AFFINITY='granularity=fine,verbose,compact,1,0'
export TF_XLA_FLAGS='--tf_xla_cpu_global_jit'
export KMP_SETTINGS='TRUE'
export OMP_NUM_THREADS='16'

scontrol update JobId=$SLURM_JOB_ID TimeLimit=1-00:00:00
. /home/davidr/tf_cpu36.sh
cd /home/davidr/projects/saraGAN/SURFGAN/
export KMP_BLOCKTIME=0
export KMP_AFFINITY='granularity=fine,verbose,compact,1,0'
export TF_XLA_FLAGS=--tf_xla_cpu_global_jit
export KMP_SETTINGS=TRUE
export OMP_NUM_THREADS=16
DIM=512
python -u main.py stylegan2 /lustre4/2/managed_datasets/LIDC-IDRI/npy/average/ '(1, 128, 512, 512)' --scratch_path '/' --starting_phase 5 --ending_phase 5 --base_dim $DIM --latent_dim $DIM --horovod --starting_alpha 0 --base_batch_size 8 --max_global_batch_size 1024 --learning_rate 0.001
