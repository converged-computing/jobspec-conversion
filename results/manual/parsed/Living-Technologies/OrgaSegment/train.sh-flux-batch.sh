#!/bin/bash
#FLUX: --job-name=spicy-house-5135
#FLUX: --queue=gpu
#FLUX: -t=691200
#FLUX: --priority=16

TRAIN=false
EVAL=false
EVALMODEL=None
while getopts :c:m:te flag
do
    case "${flag}" in
        t) TRAIN=true;;
        e) EVAL=true;;
        c) CONFIG=${OPTARG};;
        m) EVALMODEL=${OPTARG};;
    esac
done
echo "TRAIN: $TRAIN";
echo "EVAL: $EVAL";
echo "CONFIG: $CONFIG";
echo "EVALMODEL: $MODEL";
ENV=OrgaSegment
source ~/.bashrc
cd $SLURM_SUBMIT_DIR
echo $ENV
conda activate $ENV
conda info --envs
nvidia-smi
if [ "$TRAIN" = true ] ; then
    python train_mrcnn.py $SLURM_JOB_ID $CONFIG
fi
if [ "$EVAL" = true ] ; then
    python eval_mrcnn.py $SLURM_JOB_ID $CONFIG $EVALMODEL
fi
conda deactivate
