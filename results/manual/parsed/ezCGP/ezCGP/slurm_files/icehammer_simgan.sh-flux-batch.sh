#!/bin/bash
#FLUX: --job-name=ezCGP_simgan
#FLUX: -c=8
#FLUX: -t=432480
#FLUX: --urgency=16

echo "Started on `/bin/hostname`" # prints name of compute node job was started on
nvidia-smi
if [ -z "$1" ]
then
      setseed=""
else
      setseed="--seed $1"
fi
if [ -z "$2" ]
then
      setprevrun=""
else
      setprevrun="--previous_run $2"
fi
cd ~/ezCGP
module load anaconda3/2020.02
module load cuda/10.1
conda activate simgan-cgp
rm -rf ~/.nv
python main.py -p problem_simgan -v $setseed $setprevrun
