#!/bin/bash
#FLUX: --job-name=orthoRes
#FLUX: --queue=gpux2
#FLUX: -t=1440
#FLUX: --urgency=16

echo Running
module load opence/1.5.1
echo Module loaded
python runme_four.py -e 100 -t ../data/
echo Done
