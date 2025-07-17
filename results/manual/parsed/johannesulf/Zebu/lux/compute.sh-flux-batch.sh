#!/bin/bash
#FLUX: --job-name=lensing_mock_challenge
#FLUX: -n=40
#FLUX: --queue=leauthaud
#FLUX: -t=604800
#FLUX: --urgency=16

cd /data/groups/leauthaud/jolange/Zebu/lux
source init.sh
cd ../stacks/
python compute.py $SLURM_ARRAY_TASK_ID
