#!/bin/bash
#FLUX: --job-name=fashionmnist
#FLUX: -c=4
#FLUX: --queue=shared-gpu
#FLUX: -t=43200
#FLUX: --priority=16

echo $CUDA_VISIBLE_DEVICES
srun python main.py --batch-size=300 --reparam-type="mixture" --discrete-size=100 --continuous-size=40 --epochs=200 --layer-type="conv" --ngpu=1 --optimizer=adam --mut-reg=0.0 --disable-regularizers --task fashion --uid=fashionvanilla --calculate-fid --visdom-url="http://login1.cluster" --visdom-port=8098
