#!/bin/bash
#FLUX: --job-name=bumfuzzled-caramel-3886
#FLUX: -c=128
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

module load pytorch/1.11.0
mkdir -p ./outlog;
echo $lead30d
echo $memlen
echo $logname
srun python3 LSTM_NN_RMM.py > ./outlog/$logname.txt
