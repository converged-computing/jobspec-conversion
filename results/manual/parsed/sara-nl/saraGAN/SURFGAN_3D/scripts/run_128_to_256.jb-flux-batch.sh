#!/bin/bash
#FLUX: --job-name=angry-signal-0957
#FLUX: --urgency=16

export OMP_NUM_THREADS='11'
export KMP_SETTINGS='True'
export KMP_AFFINITY='granularity=fine,compact,1,0'
export TF_USE_CUDNN='0'

DATETIME=$(date "+%Y%m%d_%H%M%S")
SURFGAN_ROOT=/home/${USER}/NKI/saraGAN/SURFGAN_3D
NETWORK_ARCH=pgan
CONTINUE_PATH=${SURFGAN_ROOT}/runs/model_6_medium/model_6
LOGDIR=${SURFGAN_ROOT}/runs/${NETWORK_ARCH}/${DATETIME}
BATCH_BACKUP=${LOGDIR}/jobscript.sh
BATCH_OUT=${LOGDIR}/slurm-${SLURM_JOB_ID}.out
export OMP_NUM_THREADS=11
export KMP_SETTINGS=True
export KMP_AFFINITY="granularity=fine,compact,1,0"
export TF_USE_CUDNN=0
mkdir -p ${LOGDIR}
echo "Output of this job can be found in: ${BATCH_OUT}"
echo "Logging batch script to ${BATCH_BACKUP}" > ${BATCH_OUT}
cat "$0" > ${BATCH_BACKUP}
{
echo "Started at:"
date
source ~/venvs/surfgan/bin/activate
module purge
module load 2019
module load Horovod/0.19.4-fosscuda-2018b-TensorFlow-1.15.3-Python-3.6.6
echo "Loaded modules:"
module list
cd ${SURFGAN_ROOT}
mpirun --report-bindings --mca btl ^openib --mca btl_tcp_if_include 10.200.0.0/16 --map-by ppr:1:socket:PE=12 -x NCCL_DEBUG=INFO -x HOROVOD_MPI_THREADS_DISABLE=1 -x LD_LIBRARY_PATH -x PATH -x TF_USE_CUDNN -x OMP_NUM_THREADS \
python -u main.py $NETWORK_ARCH /projects/2/managed_datasets/LIDC-IDRI/npy/average/ '(1, 128, 512, 512)' --starting_phase 7 --ending_phase 8 --latent_dim 512 --horovod  --scratch_path /scratch-shared/$USER --base_batch_size 32 --network_size m --starting_alpha 1 --loss_fn wgan --gp_weight 10 --d_lr 5e-5 --g_lr 5e-5 --continue_path $CONTINUE_PATH --num_inter_ops 1 --logdir $LOGDIR
echo "Finished at:"
date
} > ${BATCH_OUT} 2>&1
