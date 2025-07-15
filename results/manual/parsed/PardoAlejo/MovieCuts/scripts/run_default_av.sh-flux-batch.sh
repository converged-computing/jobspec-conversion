#!/bin/bash
#FLUX: --job-name=MCe2eAV
#FLUX: -t=57600
#FLUX: --priority=16

echo `hostname`
module load cuda/11.1.1
module load gcc/6.4.0
conda activate torch1.3
DIR=/ibex/ai/home/pardogl/MovieCuts
cd $DIR
echo `pwd`
BATCH_SIZE=8
NUM_WORKERS=6
SNIPPET_SIZE=16
LR=0.03
ABETA=1.31
VBETA=4.95
AVBETA=2.74
scale_h=128 # Scale H to read
scale_w=180 # Scale W to read
crop_size=112 # crop size to input the network
INF=0
NEG_PORTION=0.0
python src/main.py --cfg cfgs/ResNet18/default.yml \
    --data.videos_path /ibex/ai/project/c2114/data/movies/framed_clips\
    --data.scale_h $scale_h\
    --data.scale_w $scale_w\
    --data.crop_size $crop_size\
    --data.negative_portion $NEG_PORTION \
    --training.num_workers $NUM_WORKERS \
    --batch_size $BATCH_SIZE \
    --data.snippet_size $SNIPPET_SIZE\
    --lr_scheduler.initial_lr $LR \
    --model.vbeta $VBETA \
    --model.abeta $ABETA \
    --model.avbeta $AVBETA\
    --base_exp_dir eccv22_experiments \
    --inference.multi_modal_inference $INF \
    --data.window_sampling gaussian \
    --wandb.use_wandb False
