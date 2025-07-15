#!/bin/bash
#FLUX: --job-name="exp_texture_grid"
#FLUX: --queue=gpu-shared
#FLUX: --priority=16

module load matlab
matlab -nodisplay -nosplash -nojvm -r "exp_texture_grid()"
