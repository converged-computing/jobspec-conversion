#!/bin/bash
#FLUX: --job-name=alternating-ftlr-100-ptlr-5e-2-bs-256-epochs-200-run2
#FLUX: --priority=16

export LD_LIBRARY_PATH='/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH'
export PYTHONPATH='$PYTHONPATH:$WORKFOLDER'

TRAIN_EPOCHS=200
FINETUNING_EPOCHS=200
EXPT_NAME="alternating-ftlr-100-ptlr-5e-2-bs-256-epochs-200-run2"
echo "TRAIN EPOCHS $TRAIN_EPOCHS"
echo "FINETUNING EPOCHS $FINETUNING_EPOCHS"
echo "EXPT NAME $EXPT_NAME"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia-384
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH
WORKFOLDER="/home/$USER/workspace/metassl"
echo $WORKFOLDER
export PYTHONPATH=$PYTHONPATH:$WORKFOLDER
source /home/ferreira/.miniconda/bin/activate metassl
echo "submitted job $EXPT_NAME"
echo "logfile at $LOG_FILE"
echo "error file at $ERR_FILE"
srun $WORKFOLDER/cluster/train_alternating_simsiam.sh $EXPT_NAME $TRAIN_EPOCHS $FINETUNING_EPOCHS
