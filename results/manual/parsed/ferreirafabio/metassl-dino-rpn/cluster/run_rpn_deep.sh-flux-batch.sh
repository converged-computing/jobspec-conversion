#!/bin/bash
#FLUX: --job-name=dino_rpn_deep
#FLUX: --queue=alldlc_gpu-rtx2080
#FLUX: -t=86399
#FLUX: --urgency=16

source /home/ferreira/.profile
source activate dino_newpt
python -m torch.distributed.launch --nproc_per_node=8 --nnodes=1 main_dino.py --arch vit_small --data_path /data/datasets/ImageNet/imagenet-pytorch/train --output_dir /work/dlclarge2/ferreira-dino-rpn/metassl-dino-rpn/experiments/$EXPERIMENT_NAME --batch_size_per_gpu $BATCH_SIZE --local_crops_number 2 --saveckp_freq 10 --epochs $EPOCHS --warmup_epochs $WARMUP_EPOCHS --use_rpn_optimizer $USE_RPN_OPTIMIZER --invert_rpn_gradients $INVERT_GRADIENTS --separate_localization_net $SEPARATE_LOCAL_NET --stn_mode $STN_MODE --deep_loc_net True --use_one_res True
