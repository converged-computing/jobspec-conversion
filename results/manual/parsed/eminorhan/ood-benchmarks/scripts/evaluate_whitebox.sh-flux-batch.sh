#!/bin/bash
#FLUX: --job-name=whi
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load cuda-10.0
source /home/eo41/venv/bin/activate
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_whitebox.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/imagenet/' --model-name 'moco_v2' 
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_whitebox.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/imagenet/' --model-name 'resnet50'
echo "Done"
