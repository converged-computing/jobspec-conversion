#!/bin/bash
#FLUX: --job-name=astute-punk-9589
#FLUX: --queue=gpu-long
#FLUX: -t=3600
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
echo "JOB timestamp: $(date)"
echo "JOB ID: $SLURM_JOB_ID"
hostname
source ~/.bashrc
conda activate usb
python --version
which python
module load cuda/11.8
nvidia-smi -L
unset LD_LIBRARY_PATH
srun python train.py --min_epochs=10 --max_epochs=500 --batch_size=512 --target_label=class --num_classes=2
