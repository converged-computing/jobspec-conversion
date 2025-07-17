#!/bin/bash
#FLUX: --job-name=brvit
#FLUX: -c=16
#FLUX: --queue=dpart
#FLUX: -t=129600
#FLUX: --urgency=50

nvidia-smi
module load cuda/11.3.1   
source ~/miniconda3/bin/activate
conda activate swin 
cd ~/Swin-Transformer
torchrun  --nproc_per_node 4  --master_port 29499  main.py --cfg configs/swin/vit_relpos_b_0304.yaml --data-path /fs/cml-datasets/ImageNet/ILSVRC2012 --output /cmlscratch/pding 
