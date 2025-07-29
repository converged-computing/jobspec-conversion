#!/bin/bash
#FLUX: --job-name=monodepth
#FLUX: -c=8
#FLUX: --queue=batch_default
#FLUX: -t=345600
#FLUX: --urgency=16

module load anaconda/3
bootstrap_conda
conda activate minienv
which python
hostname
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
top -b -d1 -n1 | grep -i "%Cpu" #This will show cpu utilization at the start of the script
LOG_FILE=val.txt
python -u ../../../train.py --data-folder /nobackup/nyuv2/data_average10/  --evaluate models_19.pth.tar 2>&1 | tee $LOG_FILE 
