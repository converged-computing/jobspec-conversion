#!/bin/bash
#FLUX: --job-name=xai_dev
#FLUX: --queue=dev
#FLUX: --urgency=16

source venv/bin/activate
python main.py --config configs/resnet18_binary_classification.yaml --verbose
