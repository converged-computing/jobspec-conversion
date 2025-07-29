#!/bin/bash
#FLUX: --job-name=MPET
#FLUX: -n=8
#FLUX: -t=3600
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$HOME/.local/lib/python2.7/site-packages/'

source /cluster/bin/jobsetup
echo $SCRATCH
source ~oyvinev/fenics1.6/fenics1.6
export PYTHONPATH=$PYTHONPATH:$HOME/.local/lib/python2.7/site-packages/
cleanup "mkdir -p /work/users/piersanti/MPET_output"
cleanup "cp -r $SCRATCH /work/users/piersanti/MPET_output"
cp -r /usit/abel/u1/piersanti/MPET $SCRATCH
cd $SCRATCH
cd MPET
mpirun --bind-to none python prova.py
