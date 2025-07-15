#!/bin/bash
#FLUX: --job-name=creamy-hobbit-7249
#FLUX: -t=5400
#FLUX: --urgency=16

source /home_expes/tools/python/python367_gpu
echo "on node: " $SLURMD_NODENAME
srun --exclusive nvidia-smi
echo ""
cmake --version
cmake -DBOOST_DIR=/home_expes/tools/boost/boost_1_66_0 .
make
srun --exclusive ./main_loop
