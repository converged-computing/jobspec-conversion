#!/bin/bash
#FLUX: --job-name=pytorch_resnet
#FLUX: -N=16
#FLUX: -t=21600
#FLUX: --urgency=16

codedir=~/scratch/horovod/examples
codepath=$codedir/pytorch_imagenet_resnet50.py
traindir=/gpfs/u/locker/200/CADS/datasets/ImageNet/train
valdir=/gpfs/u/locker/200/CADS/datasets/ImageNet/val
logdir=~/scratch/horovod/examples/logs
hostdir=~/scratch/horovod/examples/hosts
epochs=62
Batchsize=32
NP=`expr $SLURM_JOB_NUM_NODES \* $SLURM_NTASKS_PER_NODE`
. ~/scratch/miniconda3/etc/profile.d/conda.sh
conda activate wmlce-1.7.0
srun hostname -s | sort -u > $hostdir/hosts.$SLURM_JOBID
awk "{ print \$0 \"-ib\"; }" $hostdir/hosts.$SLURM_JOBID >$hostdir/tmp.$SLURM_JOBID
mv $hostdir/tmp.$SLURM_JOBID $hostdir/hosts.$SLURM_JOBID
horovodrun --verbose -np $NP   -hostfile $hostdir/hosts.$SLURM_JOBID   python $codepath --train-dir $traindir --val-dir $valdir --log-dir $logdir --fp16-allreduce --batch-size=$batchsize --epochs=$epochs
rm  $hostdir/hosts.$SLURM_JOBID
