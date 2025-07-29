#!/bin/bash
#SBATCH --account=$ACCOUNT
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8192M
#SBATCH --time=00:30:00

ml load python
ml load scipy-stack
source $HOME/langevin_env/bin/activate
N=__N__
SRAND=__SRAND__
LAMDA=__LAMDA__
python main.py --N $N --srand $SRAND --lamda $LAMDA --outfile "out_N_"$N"_srand_"$SRAND"_lamda_"$LAMDA".npy"
