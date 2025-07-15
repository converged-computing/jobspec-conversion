#!/bin/bash
#FLUX: --job-name=suepml2
#FLUX: -t=32400
#FLUX: --priority=16

module load anaconda3/2021.11
conda activate solaris
python3 /home/ap6964/suepml/train-classifier.py ResNet18-LabFrame-Classifier -c /home/ap6964/suepml/configs/resnet18-labframe-classifier.yml
