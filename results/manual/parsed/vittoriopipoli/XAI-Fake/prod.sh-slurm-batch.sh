#!/bin/bash
#FLUX: --job-name=ResNet18_FS_BW
#FLUX: --queue=prod
#FLUX: -t=360
#FLUX: --urgency=16

source venv/bin/activate
python main.py --config configs/resnet18_binary_classification.yaml --verbose
