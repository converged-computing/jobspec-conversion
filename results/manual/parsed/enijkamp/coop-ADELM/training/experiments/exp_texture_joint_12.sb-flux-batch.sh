#!/bin/bash
#FLUX: --job-name=joint_12
#FLUX: --queue=gpu-shared
#FLUX: -t=86400
#FLUX: --urgency=16

export CPATH='/home/enijkamp/cudnn-3.0/include/'
export LD_LIBRARY_PATH='/home/enijkamp/cudnn-3.0/lib64:$LD_LIBRARY_PATH'
export LIBRARY_PATH='/home/enijkamp/cudnn-3.0/lib64:$LIBRARY_PATH'

export CPATH=/home/enijkamp/cudnn-3.0/include/
export LD_LIBRARY_PATH=/home/enijkamp/cudnn-3.0/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/enijkamp/cudnn-3.0/lib64:$LIBRARY_PATH
module load matlab
matlab -nodisplay -nosplash -nojvm -r "exp_texture_joint_12()"
