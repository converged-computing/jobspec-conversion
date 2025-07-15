#!/bin/bash
#FLUX: --job-name=dsae168_36
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=54000
#FLUX: --priority=16

module load gcc/8.3.0 cuda/10.1.168
module load pytorch/1.3.0
module list
echo "Installing requirements ..."
pip install -r 'requirements.txt' --user -q --no-cache-dir
echo "Requirements installed."
echo "Start running ... "
srun python3 single_gpu_trainer_electricity.py --data_name electricity --n_multiv 327 --window 168 --horizon 36 --batch_size 64 --split_train 0.6003649635036497 --split_validation 0.19981751824817517 --split_test 0.19981751824817517
echo "Finished running!"
seff $SLURM_JOBID
