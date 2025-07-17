#!/bin/bash
#FLUX: --job-name=main
#FLUX: -N=15
#FLUX: --queue=shared-gpu
#FLUX: -t=36000
#FLUX: --urgency=16

cores=8
for dir in "$1"/*
do
if [ -d "$dir" ]
then
echo $dir
srun -N 1 -n 1 -c $cores -o "$dir".out --open-mode=append ./main_wrapper.sh --action train --epochs 50 --learning-rule stdp --load --directory $dir &
fi
done
