#!/bin/bash
#FLUX: --job-name=hairy-onion-6367
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "Hello World"
nvidia-smi
module load python/3.10 cuda cudnn
source ~/envs/lstm-transf/bin/activate
cd ~/workspace/syde770-project
tensorboard --logdir="~/scratch/lstm-transformer/outputs" --host 0.0.0.0 --load_fast false &
python run.py run ~/scratch/lstm-transformer/subjects_2023-07-12/cc_data.json ~/scratch/lstm-transformer/outputs cnn-transformer --enable-checkpoints
