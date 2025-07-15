#!/bin/bash
#FLUX: --job-name=muffled-leopard-6361
#FLUX: --priority=16

module load matlab/r2019b
matlab -nodisplay -r "run('spheres_placing3.m')"
