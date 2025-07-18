#!/bin/bash
#FLUX: --job-name=dirty-pot-4234
#FLUX: -t=3600
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/flush1/wu082/proj/claran/pyenv'

module load tensorflow/1.12.0-py36-gpu
module load nccl
module load openmpi
export PYTHONPATH=$PYTHONPATH:/flush1/wu082/proj/claran/pyenv
INPUT_IMAGE=/flush1/wu082/proj/claran/data/PNGImages/FIRSTJ104917.4+215310_logminmax.png
cd /flush1/wu082/proj/claran
mpirun -np 1 python train.py --predict $INPUT_IMAGE  \
        --load /flush1/wu082/proj/claran/train_log/17721137/model-10000 \
        --config MODE_MASK=False MODE_FPN=True \
        DATA.BASEDIR=./data \
        BACKBONE.WEIGHTS=./weights/pretrained/ImageNet-R50-AlignPadding.npz \
        DATA.TRAIN=trainD1 DATA.VAL=testD1 \
        PREPROC.TRAIN_SHORT_EDGE_SIZE=600,600 \
        PREPROC.TEST_SHORT_EDGE_SIZE=600 \
	TRAIN.LR_SCHEDULE=60000,70000,80000 \
	TEST.RESULT_SCORE_THRESH_VIS=0.7 \
	TEST.RESULT_SCORE_THRESH=0.7
