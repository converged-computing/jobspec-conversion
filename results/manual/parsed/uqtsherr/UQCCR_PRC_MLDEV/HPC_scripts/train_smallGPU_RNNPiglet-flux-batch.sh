#!/bin/bash
#FLUX: --job-name=TS_train_Piglet_EEG_Model
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load gnu7
module load cuda/11.0.2.450
module load anaconda
module load mvapich2
module load pmix/2.2.2
source activate timsTF
srun --mpi=pmi2 python ~/pycharmFwd/TF1\ work/RNNforPigletEEG.py
