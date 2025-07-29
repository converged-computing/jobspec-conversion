#!/bin/bash
#FLUX: --job-name=cworkshop_pytorch_cv
#FLUX: -c=4
#FLUX: --queue=qTRDGPU
#FLUX: -t=3600
#FLUX: --urgency=16

sleep 10s 
eval "$(conda shell.bash hook)"
conda activate cw_torch
cd $MYDIR/ClusterWorkshop/Examples/PytorchClassification
python -u mnist_classification.py --k $SLURM_ARRAY_TASK_ID
sleep 10s
