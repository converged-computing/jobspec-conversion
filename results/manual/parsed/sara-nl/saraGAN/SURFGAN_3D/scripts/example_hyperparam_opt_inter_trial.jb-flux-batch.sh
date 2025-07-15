#!/bin/bash
#FLUX: --job-name=loopy-leader-6252
#FLUX: --priority=16

export OMP_NUM_THREADS='5'
export KMP_SETTINGS='True'
export KMP_AFFINITY='granularity=fine,compact,1,0'
export TF_USE_CUDNN='1'

DATETIME=$(date "+%Y%m%d_%H%M%S")
SURFGAN_ROOT=/home/${USER}/NKI/saraGAN/SURFGAN_3D
NETWORK_ARCH=pgan
CONTINUE_PATH=${SURFGAN_ROOT}/runs/pgan/20210202_174752/model_1
LOGDIR=${SURFGAN_ROOT}/runs/${NETWORK_ARCH}/${DATETIME}
BATCH_BACKUP=${LOGDIR}/jobscript.sh
BATCH_OUT=${LOGDIR}/slurm-${SLURM_JOB_ID}.out
export OMP_NUM_THREADS=5
export KMP_SETTINGS=True
export KMP_AFFINITY="granularity=fine,compact,1,0"
export TF_USE_CUDNN=1
mkdir -p ${LOGDIR}
echo "Output of this job can be found in: ${BATCH_OUT}"
echo "Logging batch script to ${BATCH_BACKUP}" > ${BATCH_OUT}
cat "$0" > ${BATCH_BACKUP}
{
echo "Started at:"
date
cd ${SURFGAN_ROOT}
if [ -f 'classify_image_graph_def.pb' ]; then
    if [ "$SLURM_NNODES" -gt 1 ]; then
        echo "Copying inception network for FID calculation to scratch"
        module purge
        module load 2020
        module load mpicopy/4.2-gompi-2020a
        mpicopy classify_image_graph_def.pb
    else
        # Srun makes sure this code section still works even in an salloc
        srun -n 1 --ntasks-per-node 1 cp classify_image_graph_def.pb $TMPDIR
    fi
fi
source ~/.virtualenvs/surfgan/bin/activate
module purge
module load 2019
module load Horovod/0.19.4-fosscuda-2019b-TensorFlow-1.15.3-Python-3.6.6
echo "Loaded modules:"
module list
mpirun --report-bindings --map-by ppr:2:socket:PE=6 -x NCCL_DEBUG=INFO -x HOROVOD_MPI_THREADS_DISABLE=1 -x LD_LIBRARY_PATH -x PATH -x TF_USE_CUDNN -x OMP_NUM_THREADS \
python -u main.py $NETWORK_ARCH /nfs/radioct/14_pgan/npy/average/ --start_shape '(1, 5, 16, 16)' --final_shape '(1, 160, 512, 512)' --scratch_path /scratch/$USER --logdir $LOGDIR \
--gpu --num_inter_ops 1 --data_mean 1024 --data_stddev 1024 \
--starting_phase 1 --ending_phase 1 --mixing_nimg 131072 --stabilizing_nimg 131072 \
--latent_dim 128 --first_conv_nfilters 128 --network_size s --starting_alpha 1 --loss_fn wgan --gp_weight 10 --noise_stddev 0.01 \
--optuna_distributed --optuna_warmup_steps 20000 --optuna_pruner 'nopruner' \
--checkpoint_every_nsteps 50000 --summary_large_every_nsteps 4096 --summary_small_every_nsteps 2048 \
--calc_metrics --metrics_every_nsteps 10240 --compute_FID --metrics_batch_size 265 --num_metric_samples 265 \
--adam_beta1 None --adam_beta2 None
} > ${BATCH_OUT} 2>&1
