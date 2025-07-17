#!/bin/bash
#FLUX: --job-name=joint_6
#FLUX: --queue=gpu-shared
#FLUX: -t=86400
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nosplash -nojvm -r "exp_texture_joint_6()"
