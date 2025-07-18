#!/bin/bash
#FLUX: --job-name=anxious-gato-3310
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load cuda/10
/modules/apps/cuda/10.1.243/samples/bin/x86_64/linux/release/deviceQuery
module load miniconda/4.11.0
conda run -n fresh2 --no-capture-output python3.8 discrimination_task.py 1
