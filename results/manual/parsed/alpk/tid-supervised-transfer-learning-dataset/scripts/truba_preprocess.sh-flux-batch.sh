#!/bin/bash
#FLUX: --job-name=joyous-fudge-6511
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --priority=16

module load centos7.3/lib/cuda/10.1
module load centos7.3/comp/gcc/6.4
/truba/home/akindiroglu/Workspace/Libs/pytorch_nightly/bin/python generate_csv_files.py
