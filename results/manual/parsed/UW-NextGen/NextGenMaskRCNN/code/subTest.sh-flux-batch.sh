#!/bin/bash
#FLUX: --job-name=strawberry-rabbit-4529
#FLUX: --urgency=16

module load cuda/9.0
source activate maskrcnn
conda install --name maskrcnn numpy
conda install -c anaconda --name maskrcnn scikit-image
/srv/home/whao/anaconda3/envs/maskrcnn/bin/pip install -r requirements.txt
/srv/home/whao/anaconda3/envs/maskrcnn/bin/python3 setup.py install
/srv/home/whao/anaconda3/envs/maskrcnn/bin/python3 ./samples/balloon/balloon.py train --dataset=./datasets/balloon --weights=coco
