#!/bin/bash
#FLUX: --job-name=RepGAN
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

export thisuser='$(whoami)'
export hmd='/gpfs/users'
export LD_LIBRARY_PATH='/gpfs/workdir/invsem07/.conda/envs/tf/lib:$LD_LIBRARY_PATH'

export thisuser=$(whoami)
export hmd="/gpfs/users"
module purge
module load anaconda3/2020.02/gcc-9.2.0
module load cuda/10.1.243/intel-19.0.3.199
module load arm-forge/20.1.3-Redhat-7.0/intel-19.0.3.199
source activate tf
export LD_LIBRARY_PATH=/gpfs/workdir/invsem07/.conda/envs/tf/lib:$LD_LIBRARY_PATH
application=`which python3`
ddt --connect --mem-debug=balanced srun -n 1  $application %allinea_python_debug% RepGAN.py
