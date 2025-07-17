#!/bin/bash
#FLUX: --job-name=exp_texture_grid
#FLUX: --queue=gpu-shared
#FLUX: -t=7200
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nosplash -nojvm -r "exp_texture_grid()"
