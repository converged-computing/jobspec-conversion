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
python3 main_s1s2_unet_mtbs.py \
            --config-name=mtbs.yaml \
            RAND.SEED=0 \
            RAND.DETERMIN=False \
            DATA.AUGMENT=True \
            DATA.TRAIN_MASK=mtbs \
            DATA.TEST_MASK=mtbs \
            DATA.SATELLITES=['S2'] \
            DATA.PREPOST=['pre','post'] \
            DATA.STACKING=True \
            DATA.INPUT_BANDS.S2=['B4','B8','B12'] \
            MODEL.ARCH=UNet_dualHeads \
            MODEL.CLASS_WEIGHTS=[0.5,0.5,0,0] \
            MODEL.USE_DECONV=False \
            MODEL.WEIGHT_DECAY=0.01 \
            MODEL.LR_SCHEDULER=cosine \
            MODEL.BATCH_SIZE=32 \
            MODEL.MAX_EPOCH=5 \
            MODEL.STEP_WISE_LOG=False \
            EXP.NOTE=debug
echo "finish"
