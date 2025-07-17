#!/bin/bash
#FLUX: --job-name=makefig3
#FLUX: -c=30
#FLUX: -t=3600
#FLUX: --urgency=16

module load matlab/2022b.2
matlab -nodisplay -r "clear; parpool_size=30; popu_size=30; num_pareto_points=10; max_iter=2; makefig3"
