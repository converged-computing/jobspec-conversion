#!/bin/bash
#FLUX: --job-name=phat-puppy-1687
#FLUX: -c=8
#FLUX: -t=1800
#FLUX: --urgency=16

ml load python
ml load scipy-stack
source $HOME/langevin_env/bin/activate
N=__N__
SRAND=__SRAND__
LAMDA=__LAMDA__
python main.py --N $N --srand $SRAND --lamda $LAMDA --outfile "out_N_"$N"_srand_"$SRAND"_lamda_"$LAMDA".npy"
