#!/bin/bash
#FLUX: --job-name=dsaehopt
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

export PYTHONWARNINGS='ignore'

module load gcc/8.3.0 cuda/10.1.168
module load pytorch/1.3.0
module list
echo "Installing requirements ..."
pip install -r 'requirements.txt' --user -q --no-cache-dir
echo "Requirements installed."
export PYTHONWARNINGS="ignore"
echo "Start running ... "
srun python3 new_hopt_gpu_trainer_electricity.py --data_name electricity --window 168 --horizon 36 --split_train 0.1104014598540146 --split_validation 0.028284671532846715 --split_test 0.028284671532846715
echo "Finished running!"
seff $SLURM_JOBID
