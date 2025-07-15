#!/bin/bash
#FLUX: --job-name=grated-dog-8836
#FLUX: --priority=16

export PATH='$HOME/project/anaconda3/bin:$PATH'

export PATH="$HOME/project/anaconda3/bin:$PATH"
source activate tfgpu
cd /homedtic/cmorales/cmol/ggnn
python tf2/chem_tensorflow_dense.py $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}
