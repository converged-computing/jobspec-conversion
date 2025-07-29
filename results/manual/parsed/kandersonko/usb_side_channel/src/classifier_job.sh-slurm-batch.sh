#!/bin/bash
#FLUX: --job-name=classifier-job
#FLUX: --queue=gpu-8
#FLUX: -t=7200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
echo "JOB timestamp: $(date)"
echo "JOB ID: $SLURM_JOB_ID"
hostname
source ~/.bashrc
nvidia-smi -L
conda activate usb2
python --version
which python
unset LD_LIBRARY_PATH
srun python classifier.py --log --method=tsfresh --dataset=dataset_a --target_label=category --classifier=lstm --task=identification --batch_size=32
