#!/bin/bash
#FLUX: --job-name=det_training
#FLUX: -c=4
#FLUX: -t=3600
#FLUX: --urgency=16

​
​
DATASETS=(voc2007)
​
DATATYPE=(custom custom_single_class)
VAL_DATASETS=(voc_2007_test_custom voc_2007_test_single_class)
NUM_CLASSES=(20 1)
PORT=$((1024+$RANDOM))
DIST_URL=tcp://0.0.0.0:$PORT
NUM_DATASETS=${#DATASETS[@]}
NUM_TYPES=${#DATATYPE[@]}
​
type_id=$((SLURM_ARRAY_TASK_ID%NUM_TYPES))
dataset_id=$((SLURM_ARRAY_TASK_ID/NUM_TYPES))
​
EXP_NAME="experiments/"${DATASETS[$dataset_id]}"_dino_init_"${DATATYPE[$type_id]}"_run4_144kiter"
WEIGHTS_PATH="experiments/"${DATASETS[$dataset_id]}"_dino_init_"${DATATYPE[$type_id]}"_run4_144kiter/model_final.pth"
TRAIN_DATASET=${DATASETS[$dataset_id]}"_"${DATATYPE[$type_id]}
​
source /vulcanscratch/archswam/miniconda3/bin/activate
conda activate pytorch
srun python plain_train_net.py --dist-url $DIST_URL --config-file ./configs/faster_rcnn_R_50_C4_3x.yaml --num-gpus 2 --eval-only TEST.EVAL_PERIOD 5000 OUTPUT_DIR $EXP_NAME SOLVER.BASE_LR 0.01 SOLVER.IMS_PER_BATCH 8 DATALOADER.NUM_WORKERS 4 SEED 1235 DATASETS.TRAIN '("'$TRAIN_DATASET'",)' DATASETS.TEST '("'${VAL_DATASETS[$type_id]}'",)' MODEL.WEIGHTS $WEIGHTS_PATH  MODEL.ROI_HEADS.NUM_CLASSES ${NUM_CLASSES[$type_id]} MODEL.ROI_HEADS.NAME Res5ROIHeadsExtraNorm MODEL.RESNETS.NORM SyncBN
​
