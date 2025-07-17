#!/bin/bash
#FLUX: --job-name=roberta-flash-attention
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=1200
#FLUX: --urgency=16

module load miniconda/4.12.0
conda init bash
conda activate kiddothe2b
echo $SLURMD_NODENAME
echo $CUDA_VISIBLE_DEVICES
python demo_mlm.py --model_class roberta
echo "----------------------------------------"
python demo_mlm.py --model_class flash-roberta
