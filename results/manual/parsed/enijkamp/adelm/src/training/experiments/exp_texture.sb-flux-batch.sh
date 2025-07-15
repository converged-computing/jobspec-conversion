#!/bin/bash
#FLUX: --job-name="tex"
#FLUX: --queue=gpu-shared
#FLUX: --priority=16

module load matlab
matlab -nodisplay -nosplash -nojvm -r "exp_texture()"
