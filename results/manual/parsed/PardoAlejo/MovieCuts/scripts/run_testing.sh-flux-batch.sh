#!/bin/bash
#FLUX: --job-name=MCe2eAV
#FLUX: -t=14340
#FLUX: --priority=16

z#!/bin/bash --login
echo `hostname`
module load cuda/11.1.1
module load gcc/6.4.0
conda activate moviecuts
DIR=/ibex/ai/home/pardogl/LTC-e2e
cd $DIR
echo `pwd`
BATCH_SIZE=224
NUM_WORKERS=12
CKPT=checkpoints/epoch=7_Validation_loss=1.91.ckpt
SAVE_PATH=OUTPUTS
DATA_PATH=/ibex/ai/project/c2114/data/movies/framed_clips
python src/main.py --cfg cfgs/ResNet18/default.yml \
    --data.videos_path ${DATA_PATH}\
    --training.num_workers $NUM_WORKERS \
    --batch_size $BATCH_SIZE \
    --inference.checkpoint ${CKPT} \
    --inference.save_path ${SAVE_PATH} \
    --mode.train False \
    --mode.inference True \
    --inference.validation True \
    --inference.test False
python src/main.py --cfg cfgs/ResNet18/default.yml \
    --data.videos_path ${DATA_PATH}\
    --training.num_workers $NUM_WORKERS \
    --batch_size $BATCH_SIZE \
    --inference.checkpoint ${CKPT} \
    --inference.save_path ${SAVE_PATH} \
    --mode.train False \
    --mode.inference True \
    --inference.validation True
