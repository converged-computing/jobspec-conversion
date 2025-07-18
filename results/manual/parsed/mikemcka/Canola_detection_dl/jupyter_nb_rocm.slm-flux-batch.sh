#!/bin/bash
#FLUX: --job-name=pyfast
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

export SINGULARITYENV_ROCM_HOME='$ROCM_HOME'
export OMP_NUM_THREADS='1'

image='/scratch/pawsey0149/mmckay/pytorch_latest.sif'
nbs_dir='/scratch/pawsey0149/mmckay'
home_dir='/scratch/pawsey0149/mmckay/fake_home'
module load singularity/3.11.4-nompi
module load rocm/5.2.3
export SINGULARITYENV_ROCM_HOME=$ROCM_HOME
export OMP_NUM_THREADS=1
srun -N 1 -n 1 -c 8 --gpus-per-node=1 --gpus-per-ta
k=1  singularity run \
                      -B ${home_dir}:/home/mmckay \
                      -B ${nbs_dir}:/nbs_dir \
		      -B /scratch/pawsey0149/mmckay/10-docker2singularity.sh:/.singularity.d/env/10-docker2singularity.sh \
                      $image \
                     /home/mmckay/.local/bin/jupyter notebook --no-browser --port=7777 --ip 0.0.0.0 --notebook-dir /nbs_dir
