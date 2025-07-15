#!/bin/bash
#FLUX: --job-name=RGBDTC
#FLUX: -t=86400
#FLUX: --priority=16

ml purge
ml PyTorch
ml torchvision
t=1
while [ ${t} -le $3 ]
do
python main.py -t $1 -n $2 --name $1-F_$2_1-0_${t} --rgb 1 --depth 0 --frozen 1 ${@:4}
python main.py -t $1 -n $2 --name $1-F_$2_0-1_${t} --rgb 0 --depth 1 --frozen 1 ${@:4}
python main.py -t $1 -n $2 --name $1-F_$2_1-1_${t} --rgb 1 --depth 1 --frozen 1 ${@:4}
(( t++ ))
done
