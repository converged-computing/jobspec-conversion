#!/bin/bash
#FLUX: --job-name=comp_422_openmp
#FLUX: -N=2
#FLUX: -c=14
#FLUX: --queue=soc-gpu-kp
#FLUX: -t=600
#FLUX: --priority=16

ulimit -c unlimited -s
mpiexec -n 2 python -m ytopt.search.async_search --prob_path=problems/convolution-2d2/problem.py --exp_dir=experiments/convolution_mk4 --prob_attr=problem --exp_id=convolution_mk4  --max_time=60 --base_estimator='RF' --patience_fac=30
