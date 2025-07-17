#!/bin/bash
#FLUX: --job-name=sketch
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
module load cuda-10.0
source /home/eo41/venv/bin/activate
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_imagenets.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/imagenet-sketch/' --model-name 'moco_v2'
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_imagenets.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/imagenet-sketch/' --model-name 'resnet50'
echo "Done"
