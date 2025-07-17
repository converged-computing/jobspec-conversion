#!/bin/bash
#FLUX: --job-name=swampy-underoos-3349
#FLUX: -c=6
#FLUX: -t=150
#FLUX: --urgency=16

source $HOME/Venvs/pytorch.1.2.0/bin/activate 
module load cuda/10.0.130
python main.py --cudaid 0 --yaml bach-part-a-2018.yaml --bsize 8 --lr 0.001 --wdecay 1e-05 --momentum 0.9 --epoch 1000 --stepsize 100 --modelname resnet18 --alpha 0.6 --kmax 0.1 --kmin 0.1 --dout 0.0 --modalities 5 --pretrained True  --dataset bach-part-a-2018 --split 0 --fold 0  --loss LossCE  
