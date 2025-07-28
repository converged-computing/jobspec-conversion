#!/bin/bash
#FLUX: --job-name=eval_depth
#FLUX: -t=14400
#FLUX: --urgency=16

which python
echo $HOSTNAME
nvidia-smi 
echo $HOSTNAME
python eval_depth.py --scale --depth_model udepth --saved_model saved_models/udepth_pretrained2/dispnet_model_best.pth.tar
