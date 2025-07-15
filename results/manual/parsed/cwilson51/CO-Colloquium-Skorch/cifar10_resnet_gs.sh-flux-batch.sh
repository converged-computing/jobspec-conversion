#!/bin/bash
#FLUX: --job-name=hanky-lemur-6497
#FLUX: -t=180
#FLUX: --urgency=16

module load python
module list
source /path/to/your/env/bin/activate
python cifar10_resnet.py --max_epochs 50 --n_jobs 1 --batch_size 2000
