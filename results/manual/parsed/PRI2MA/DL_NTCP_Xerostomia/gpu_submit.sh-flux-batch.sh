#!/bin/bash
#FLUX: --job-name=Xerostomia
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --urgency=16

module purge
module load fosscuda/2020b
module load OpenCV/4.2.0-foss-2020a-Python-3.8.2-contrib
module load Python/3.8.6-GCCcore-10.2.0
source /data/$USER/.envs/xerostomia_38/bin/activate
python3 main.py
