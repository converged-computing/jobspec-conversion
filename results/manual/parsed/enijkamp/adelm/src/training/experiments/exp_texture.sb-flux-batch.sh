#!/bin/bash
#FLUX: --job-name=tex
#FLUX: --queue=gpu-shared
#FLUX: -t=7200
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nosplash -nojvm -r "exp_texture()"
