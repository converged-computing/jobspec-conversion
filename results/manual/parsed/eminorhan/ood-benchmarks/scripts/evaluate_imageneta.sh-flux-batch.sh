#!/bin/bash
#FLUX: --job-name=ina
#FLUX: -t=21600
#FLUX: --urgency=16

module purge
module load cuda-10.0
source /home/eo41/venv/bin/activate
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_imageneta.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/imagenet_a/' --model-name 'moco_v2'
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_imageneta.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/imagenet_a/' --model-name 'resnet50'
echo "Done"
