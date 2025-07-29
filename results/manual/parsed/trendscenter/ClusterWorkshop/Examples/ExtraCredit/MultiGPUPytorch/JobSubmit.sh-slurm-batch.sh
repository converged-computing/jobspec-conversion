#!/bin/bash
#FLUX: --job-name=cworkshop_pytorch
#FLUX: -c=8
#FLUX: --queue=qTRDGPU
#FLUX: -t=3600
#FLUX: --urgency=16

sleep 10s 
eval "$(conda shell.bash hook)"
conda activate cw_torch
cd $MYDIR/ClusterWorkshop/Examples/ExtraCredit/MultiGPUPytorch
python -u dataparallel.py
sleep 10s
