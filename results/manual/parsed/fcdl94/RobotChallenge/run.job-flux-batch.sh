#!/bin/bash
#FLUX: --job-name=RGBDTC
#FLUX: -t=86400
#FLUX: --urgency=16

ml purge
ml PyTorch
ml torchvision
t=1
while [ ${t} -le $5 ]
do
python main.py -t $1 -n $2 --name $1_$2_$3-$4_${t} --rgb $3 --depth $4 ${@:6}
(( t++ ))
done
