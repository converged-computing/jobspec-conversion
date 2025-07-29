#!/bin/bash
#FLUX: --job-name=train
#FLUX: -t=604800
#FLUX: --urgency=16

echo "start"
echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
echo
nvidia-smi
. /geoinfo_vol1/puzhao/miniforge3/etc/profile.d/conda.sh
conda activate pytorch
PYTHONUNBUFFERED=1; 
CFG=$SLURM_ARRAY_TASK_ID
echo "Running simulation $CFG"
echo "---------------------------------------------------------------------------------------------------------------"
for SAT in S1,S2 S1,ALOS S1,ALOS
do
    echo "Running simulation $SAT"
    echo "---------------------------------------------------------------------------------------------------------------"
    python3 main_s1s2_unet.py \
                --config-name=unet.yaml \
                RAND.SEED=$CFG \
                RAND.DETERMIN=False \
                DATA.TRAIN_MASK=poly \
                DATA.SATELLITES=[$SAT] \
                DATA.STACKING=True \
                MODEL.ARCH=UNet \
                MODEL.ENCODER=resnet18 \
                MODEL.ENCODER_WEIGHTS=imagenet \
                MODEL.USE_DECONV=False \
                MODEL.WEIGHT_DECAY=0.01 \
                MODEL.LR_SCHEDULER=cosine \
                MODEL.BATCH_SIZE=16 \
                MODEL.NUM_CLASS=2 \
                MODEL.LOSS_TYPE=CrossEntropyLoss \
                MODEL.ACTIVATION=softmax2d \
                MODEL.MAX_EPOCH=100 \
                EXP.FOLDER=Canada_RSE_2022 \
                EXP.NOTE=CE
done
echo "finish"
