#!/bin/bash
#FLUX: --job-name=tld
#FLUX: --queue=week
#FLUX: -t=172799
#FLUX: --urgency=16

cd /home/stud125/TrafficLightDetection/StateDetection
singularity exec --nv /home/stud125/sdc_gym_amd64.simg python -u /home/stud125/TrafficLightDetection/StateDetection/train.py --max_keep 1200 --num_epochs 15 --log_interval 5000 --device "cuda"
echo DONE!
