#!/bin/bash
#FLUX: --job-name=SampleJob
#FLUX: -c=2
#FLUX: --queue=gpu_shared_course
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
module load 2021
module load Anaconda3/2021.05
source deactivate
source activate gcn-gpu
python imagenet_pipeline.py
