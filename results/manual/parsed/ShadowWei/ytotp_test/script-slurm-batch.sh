#!/bin/bash
#FLUX: --job-name=comp_422_openmp
#FLUX: -N=2
#FLUX: -c=14
#FLUX: --queue=soc-kp
#FLUX: -t=600
#FLUX: --urgency=16

ulimit -c unlimited -s
mpiexec -n 2 python -m ytopt.search.async_search --prob_path=problems/convolution-2d/problem.py --exp_dir=experiments/exp-4 --prob_attr=problem --exp_id=exp-4  --max_time=60 --base_estimator='RF'
