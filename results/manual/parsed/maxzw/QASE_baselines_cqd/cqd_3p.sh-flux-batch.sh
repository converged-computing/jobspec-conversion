#!/bin/bash
#FLUX: --job-name=peachy-cherry-7466
#FLUX: -c=2
#FLUX: --queue=gpu_shared
#FLUX: -t=3600
#FLUX: --urgency=16

module purge all
module load 2021
module load Anaconda3/2021.05
SCRATCH_DIRECTORY=/global/work/${USER}/kelp/${SLURM_JOBID}
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}
source /home/${USER}/.bashrc
source activate thesis
srun python main.py --do_valid --do_test -n 1 -b 1000 -d 1000 --cpu_num 0 --geo cqd --valid_steps 20 \
--tasks 3p --print_on_screen --test_batch_size 1 --cqd discrete --cqd-t-norm prod --cqd-k 4 --cuda ${@:1}
