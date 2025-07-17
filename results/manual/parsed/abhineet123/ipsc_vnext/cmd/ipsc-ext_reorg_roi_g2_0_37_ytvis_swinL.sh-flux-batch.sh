#!/bin/bash
#FLUX: --job-name=ipsc-ext_reorg_roi_g2_0_38_ytvis_swinL
#FLUX: -c=4
#FLUX: -t=2880
#FLUX: --urgency=16

module load cuda cudnn gcc python/3.8
source ~/venv/vnext/bin/activate
nvidia-smi
python3 projects/IDOL/train_net.py --config-file projects/IDOL/configs/idol-ipsc-ext_reorg_roi_g2_0_38_ytvis_swinL.yaml --num-gpus 2 
