#!/bin/bash
#FLUX: --job-name=boopy-signal-8151
#FLUX: --urgency=16

module load matlab/r2019b
matlab -nodisplay -r "run('spheres_placing3.m')"
