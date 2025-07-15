#!/bin/bash
#FLUX: --job-name=doopy-destiny-0238
#FLUX: -c=8
#FLUX: --urgency=16

nvidia-smi
python /home/sist/luoxin/projects/DualFormer/basicsr/train.py --auto_resume -opt options/train/train_esrgan_x4_dual_former.yml
