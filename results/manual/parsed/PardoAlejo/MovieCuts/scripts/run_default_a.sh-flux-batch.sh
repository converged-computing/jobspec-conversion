#!/bin/bash
#FLUX: --job-name=MCe2eA
#FLUX: -t=43200
#FLUX: --urgency=16

echo `hostname`
module load cuda/11.1.1
module load gcc/6.4.0
source activate torch1.3
DIR=/ibex/ai/home/pardogl/LTC-e2e
cd $DIR
echo `pwd`
BATCH_SIZE=112
NUM_WORKERS=6
SNIPPET_SIZE=16
LR=0.2
ABETA=1
VBETA=0
AVBETA=0
scale_h=128 # Scale H to read
scale_w=180 # Scale W to read
crop_size=112 # crop size to input the network
python src/main.py --cfg cfgs/ResNet18/default.yml \
    --data.videos_path /ibex/ai/project/c2114/data/movies/framed_clips\
    --data.scale_h $scale_h\
    --data.scale_w $scale_w\
    --data.crop_size $crop_size\
    --training.num_workers $NUM_WORKERS \
    --batch_size $BATCH_SIZE \
    --data.snippet_size $SNIPPET_SIZE\
    --lr_scheduler.initial_lr $LR \
    --model.vbeta $VBETA \
    --model.abeta $ABETA \
    --model.avbeta $AVBETA\
    --base_exp_dir experiments\
    --model.visual_stream False
