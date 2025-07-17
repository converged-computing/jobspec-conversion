#!/bin/bash
#FLUX: --job-name=dsap4hopt
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=176340
#FLUX: --urgency=16

module load gcc/8.3.0 cuda/10.1.168
module load pytorch/1.3.0
module list
echo "Installing requirements ..."
pip install -r 'requirements.txt' --user -q --no-cache-dir
echo "Requirements installed."
echo "Start running ... "
srun python3 hopt_gpu_trainer_power.py --data_name europe_power_system --window 168 --n_multiv 183 --horizon 36 --split_train 0.11267605633802817 --split_validation 0.02910798122065728 --split_test 0.02910798122065728
echo "Finished running!"
seff $SLURM_JOBID
