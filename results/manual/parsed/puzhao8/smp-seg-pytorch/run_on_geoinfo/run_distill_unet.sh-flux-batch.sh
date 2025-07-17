#!/bin/bash
#FLUX: --job-name=distill-unet
#FLUX: -c=8
#FLUX: -t=604800
#FLUX: --urgency=16

echo "start"
echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
echo
nvidia-smi
. /geoinfo_vol1/puzhao/miniforge3/etc/profile.d/conda.sh
SAT=('ND' 'VH' 'VV')
CFG=${SAT[$SLURM_ARRAY_TASK_ID]}
echo "Running simulation $CFG"
echo "---------------------------------------------------------------------------------------------------------------"
conda activate pytorch
PYTHONUNBUFFERED=1; 
python3 main_s1s2_distill_unet.py \
            --config-name=distill_unet.yaml \
            RAND.SEED=0 \
            RAND.DETERMIN=False \
            DATA.SATELLITES=['S1','S2'] \
            DATA.STACKING=True \
            DATA.INPUT_BANDS.S1=['ND','VH','VV'] \
            DATA.INPUT_BANDS.S2=['B4','B8','B12'] \
            MODEL.ARCH=distill_unet \
            MODEL.L2_NORM=False \
            MODEL.USE_DECONV=True \
            MODEL.WEIGHT_DECAY=0.01 \
            MODEL.NUM_CLASS=1 \
            MODEL.LOSS_TYPE=DiceLoss \
            MODEL.LOSS_COEF=[1,0,0] \
            MODEL.LR_SCHEDULER=cosine \
            MODEL.ACTIVATION=sigmoid \
            MODEL.BATCH_SIZE=16 \
            MODEL.MAX_EPOCH=100 \
            EXP.NOTE=1_0_0_Jan15
echo "finish"
