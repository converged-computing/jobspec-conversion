#!/bin/bash
#FLUX: --job-name=evasive-house-1203
#FLUX: --queue=GPU-AI
#FLUX: -t=7200
#FLUX: --urgency=16

cd /home/hbeatson/
module load singularity
singularity exec runtimeEnv.simg python /home/hbeatson/jupyter_runtime_dir/HIV/HIV_scan_classifier.py -p 2 -lr 0.00015 -b 5 -e 50
pwd
singularity exec runtimeEnv.simg python /home/hbeatson/jupyter_runtime_dir/HIV/HIV_scan_classifier.py -p 2 -lr 0.00015 -b 15 
