#!/bin/bash
#FLUX: --job-name=dsap16836
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module load gcc/8.3.0 cuda/10.1.168
module load pytorch/1.3.0
module list
echo "Installing requirements ..."
pip install -r 'requirements.txt' --user -q --no-cache-dir
echo "Requirements installed."
echo "Start running ... "
srun python3 hopt_gpu_trainer_power_full.py --data_name europe_power_system --n_multiv 183 --window 168 --horizon 36 --batch_size 128 --split_train 0.7004694835680751 --split_validation 0.14929577464788732 --split_test 0.15023474178403756
echo "Finished running!"
seff $SLURM_JOBID
