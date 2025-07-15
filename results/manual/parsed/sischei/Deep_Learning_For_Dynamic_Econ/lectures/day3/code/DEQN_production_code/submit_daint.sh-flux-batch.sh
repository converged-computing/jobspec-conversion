#!/bin/bash
#FLUX: --job-name=DEQ_1
#FLUX: -c=12
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PYTHONPATH='/scratch/snx3000/simonsch/DSGE/DSGE_DEQ/src/sudden_stop/venv/lib/python3.8/site-packages:$PYTHONPATH'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load cray-python/3.8.2.1
module load daint-gpu
module load TensorFlow/2.2.0-CrayGNU-20.08-cuda-10.1.168 
source venv/bin/activate
export PYTHONPATH=/scratch/snx3000/simonsch/DSGE/DSGE_DEQ/src/sudden_stop/venv/lib/python3.8/site-packages:$PYTHONPATH
srun python run_deepnet.py 
