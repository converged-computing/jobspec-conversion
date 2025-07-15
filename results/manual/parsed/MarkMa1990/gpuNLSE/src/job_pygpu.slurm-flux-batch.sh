#!/bin/bash
#FLUX: --job-name=purple-motorcycle-9114
#FLUX: -t=5400
#FLUX: --priority=16

source /home_expes/tools/python/python367_gpu
echo "on node: " $SLURMD_NODENAME
srun --exclusive nvidia-smi
echo ""
cmake --version
cmake -DBOOST_DIR=/home_expes/tools/boost/boost_1_66_0 .
make
srun --exclusive ./main_loop
