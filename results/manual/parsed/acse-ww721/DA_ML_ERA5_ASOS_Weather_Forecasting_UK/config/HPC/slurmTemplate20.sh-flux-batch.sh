#!/bin/bash
#FLUX: --job-name=example
#FLUX: -n=2
#FLUX: -c=5
#FLUX: -t=240
#FLUX: --urgency=16

ww721@ese-hivemind:/raid/hivemind$ cat slurmTemplate20.sh 
source ~/miniconda3/etc/profile.d/conda.sh
conda activate testgpu
python xavier.py 0&
python xavier.py 1&
wait
exit 0
