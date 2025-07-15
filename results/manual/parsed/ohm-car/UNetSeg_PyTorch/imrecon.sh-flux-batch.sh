#!/bin/bash
#FLUX: --job-name=mlrseg
#FLUX: -t=907200
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/'

DT=`date +"%m-%d_%H-%M"`
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
source activate unet
cp /nfs/ada/oates/users/omkark1/Thesis_Work/Datasets.zip /scratch/$SLURM_JOBID
unzip -q /scratch/$SLURM_JOBID/Datasets.zip -d /scratch/$SLURM_JOBID
python /nfs/ada/oates/users/omkark1/Thesis_Work/UNetSeg_PyTorch/optuna_train_multiloss.py -rd=/scratch/$SLURM_JOBID -b=128 -e=60
mv output_$SLURM_JOBID.log /nfs/ada/oates/users/omkark1/Thesis_Work/UNetSeg_PyTorch/outfiles/multiloss/output_$DT.log
mv output_$SLURM_JOBID.err /nfs/ada/oates/users/omkark1/Thesis_Work/UNetSeg_PyTorch/outfiles/multiloss/output_$DT.err
