#!/bin/bash
#FLUX: --job-name=muffled-butter-2797
#FLUX: --queue=paula-gpu
#FLUX: -t=36000
#FLUX: --urgency=16

module load matplotlib
pip install --upgrade pip
pip install --user -e ../
pip install --user -r ../requirements.txt
python ids_cluster.py -d $1 -s $2 -e $3 -n $4 -w $5 -t $6
