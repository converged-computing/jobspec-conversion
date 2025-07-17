#!/bin/bash
#FLUX: --job-name=psycho-milkshake-5516
#FLUX: --queue=sbel_cmg
#FLUX: -t=600
#FLUX: --urgency=16

module load matlab/r2019b
matlab -nodisplay -r "run('spheres_placing3.m')"
