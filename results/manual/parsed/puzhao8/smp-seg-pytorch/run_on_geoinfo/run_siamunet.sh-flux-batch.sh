#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=8
#FLUX: --priority=16

echo "start"
echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
echo
nvidia-smi
. /geoinfo_vol1/puzhao/miniforge3/etc/profile.d/conda.sh
conda activate pytorch
PYTHONUNBUFFERED=1; 
CFG=$SLURM_ARRAY_TASK_ID
echo "Running simulation SEED $CFG"
echo "---------------------------------------------------------------------------------------------------------------"
for ARCH in SiamUnet_conc SiamUnet_diff DualUnet_LF
do
    echo "Running simulation ARCH $ARCH"
    echo "---------------------------------------------------------------------------------------------------------------"
    python3 main_s1s2_unet.py \
                --config-name=siam_unet.yaml \
                RAND.SEED=$CFG \
                RAND.DETERMIN=False \
                DATA.TRAIN_MASK=poly \
                DATA.SATELLITES=['S1'] \
                DATA.STACKING=False \
                DATA.INPUT_BANDS.S1=['ND','VH','VV'] \
                DATA.INPUT_BANDS.S2=['B4','B8','B12'] \
                MODEL.ARCH=$ARCH \
                MODEL.SHARE_ENCODER=True \
                MODEL.USE_DECONV=False \
                MODEL.WEIGHT_DECAY=0.01 \
                MODEL.LR_SCHEDULER=cosine \
                MODEL.ACTIVATION=softmax2d \
                MODEL.BATCH_SIZE=16 \
                MODEL.MAX_EPOCH=3 \
                EXP.NOTE=WSt-test
done
echo "finish"
