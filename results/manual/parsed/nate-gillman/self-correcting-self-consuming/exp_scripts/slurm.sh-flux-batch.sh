#!/bin/bash
#FLUX: --job-name=wobbly-banana-2797
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/lib/nvidia'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/users/$USER/.mujoco/mujoco210/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia
module load mesa
module load boost/1.80.0
module load patchelf
module load glew
module load cuda
module load ffmpeg
source /gpfs/runtime/opt/anaconda/2020.02/etc/profile.d/conda.sh
conda activate /gpfs/home/ngillman/.conda/envs/scsc
HOME_DIR=/oscar/data/superlab/users/nates_stuff/self-correcting-self-consuming
cd ${HOME_DIR}
