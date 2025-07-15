#!/bin/bash
#FLUX: --job-name=lstm-train
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: --priority=16

set -euxo pipefail
srun nvidia-smi
env
CONDA_DIR=/apps/anaconda3/2021.05/etc/profile.d  # depend on the farm config
WK_DIR=/home/xmei/projects/gluex-tracking-pytorch-lstm/python
source /etc/profile.d/modules.sh
module use /apps/modulefiles
module load anaconda3
which conda
conda --version
sh $CONDA_DIR/conda.sh
conda-env list
pwd
cd $WK_DIR
pwd
source activate pytorch-cuda11_6  # "source activate" instead of "conda activate"
srun python LSTM_training.py
srun python validation_processing.py
mkdir job_${SLURM_JOBID}
mv *.png *.pt *.log *.out job_${SLURM_JOBID}
