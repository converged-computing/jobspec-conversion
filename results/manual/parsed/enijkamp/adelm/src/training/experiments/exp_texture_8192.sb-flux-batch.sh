#!/bin/bash
#FLUX: --job-name=tex8192
#FLUX: --queue=gpu-shared
#FLUX: -t=18000
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nosplash -nojvm -r "exp_texture_8192()"
