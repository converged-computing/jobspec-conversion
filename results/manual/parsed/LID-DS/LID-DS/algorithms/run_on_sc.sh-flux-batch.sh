#!/bin/bash
#FLUX: --job-name=arid-milkshake-8723
#FLUX: --queue=paula-gpu
#FLUX: -t=36000
#FLUX: --priority=16

module load matplotlib
pip install --upgrade pip
pip install --user -e ../
pip install --user -r ../requirements.txt
python ids_cluster.py -d $1 -s $2 -e $3 -n $4 -w $5 -t $6
