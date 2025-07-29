#!/bin/bash
#FLUX: --job-name=rohib
#FLUX: -c=40
#FLUX: --queue=qTRDGPUM
#FLUX: -t=444000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/'

sleep 5s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/
source activate imagenet
python main.py --arch resnet110 --batch-size 128 --epochs 200 --lr 0.1 --lr-drop 80 120 160 \
--exp-name resnet110/baseline
    # python main.py --arch resnet110 --batch-size 128 --epochs 250 --lr 0.1 --lr-drop 80 120 160 200 \
    # --exp-name resnet110_kernel/gspS${SPS}/gsp --gsp-training --gsp-start-ep 40 --gsp-sps ${SPS}
        # python main.py --arch resnet110 --batch-size 128 --epochs 250 --lr 0.01 --lr-drop 80 120 160 200 \
        # --exp-name $parent/gspS$dir/fine_$sps --finetune --finetune-sps $sps \
        # --resume ./results/$parent/gspS$dir/gsp/model_best.pth.tar \
