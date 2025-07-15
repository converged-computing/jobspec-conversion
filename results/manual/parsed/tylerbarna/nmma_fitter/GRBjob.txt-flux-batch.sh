#!/bin/bash
#FLUX: --job-name=adorable-animal-7249
#FLUX: -c=4
#FLUX: -t=28799
#FLUX: --priority=16

source /home/cough052/barna314/anaconda3/bin/activate nmma
python /home/cough052/barna314/nmma_fitter/nmma_fit.py --datafile "$1" --candname "$2" --model "$3" --dataDir "$4" --nlive 128 --cpus 4
