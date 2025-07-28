#!/bin/bash
#FLUX: --job-name=DAC-1
#FLUX: --queue=gpu
#FLUX: --urgency=16

echo "*"{,,,,,,,,,}
echo $SLURM_JOB_ID
echo "*"{,,,,,,,,,}
nvidia-smi
source ~/.bashrc
cd /home/sriniana/projects/mic/chest-pa1/DomainAdaptativeClassifier/xray_classification
CONDA_BASE=$(conda info --base) ;
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate mic
NUM_GPU=1
GPUS=0
PORT=12346
python3 train.py --config config.json
