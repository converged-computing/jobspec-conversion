#!/bin/bash
#FLUX: --job-name=rohib
#FLUX: -c=5
#FLUX: --queue=qTRDGPUM
#FLUX: -t=444000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/'

sleep 5s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/
source activate imagenet
model='resnet32'
parent='resnets/resnet32_ker'
for dir in '0.80'
do
    for sps in '0.80' '0.85' '0.90' '0.95' '0.97'
    do
        python main.py --arch $model --batch-size 128 --epochs 250 --lr 0.001 --lr-drop 80 120 160 200 \
        --exp-name $parent/gspS$dir/fine_$sps --finetune --finetune-sps $sps \
        --resume ./results/$parent/gspS$dir/gsp/model_best.pth.tar    
    done
done
