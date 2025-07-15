#!/bin/bash
#FLUX: --job-name=shapebias
#FLUX: -t=21600
#FLUX: --priority=16

module purge
module load cuda-10.0
source /home/eo41/venv/bin/activate
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_shapebias.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/shape_bias/' --model-name 'moco_v2'
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_shapebias.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/shape_bias/' --model-name 'resnet50'
echo "Done"
