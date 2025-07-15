#!/bin/bash
#FLUX: --job-name="REPLACE_JOB_NAME"
#FLUX: -c=4
#FLUX: --queue=deep
#FLUX: --priority=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
NPROCS=`sbatch --nodes=${SLURM_NNODES} bash -c 'hostname' |wc -l`
echo NPROCS=$NPROCS
cd ../moco; python main_lincls.py -a resnet18 --lr REPLACE_LR \
        --batch-size 48 \
        --dist-url 'tcp://localhost:10001' --multiprocessing-distributed \
        --pretrained REPLACE_CHECKPOINT \
        --world-size 1 --rank 0 REPLACE_COS \
        --train_data REPLACE_TRAIN \
        --val_data REPLACE_VALID\
        --test_data REPLACE_TEST \
        --from-imagenet REPLACE_SEMI \
        --binary \
        --aug-setting chexpert --rotate --maintain-ratio \
        --exp-name REPLACE_EXP_NAME
echo "Done"
