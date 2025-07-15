#!/bin/bash
#FLUX: --job-name=grated-squidward-3958
#FLUX: --priority=16

sleep 10s 
eval "$(conda shell.bash hook)"
conda activate cw_torch
cd $MYDIR/ClusterWorkshop/Examples/ExtraCredit/MultiGPUPytorch
python -u dataparallel.py
sleep 10s
