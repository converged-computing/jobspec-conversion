#!/bin/bash
#FLUX: --job-name=blank-staircase-2979
#FLUX: -c=2
#FLUX: -t=28799
#FLUX: --urgency=16

source /home/cough052/barna314/anaconda3/bin/activate nmma
python /panfs/roc/groups/7/cough052/barna314/nmma_fitter/nmma_fit.py --datafile "$1" --candname "$2" --model "$3" --dataDir "$4" --nlive 512 --cpus 2
