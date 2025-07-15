#!/bin/bash
#FLUX: --job-name=bumfuzzled-poodle-7603
#FLUX: --queue=V100
#FLUX: --urgency=16

set -x
cd /home/ids/hrami
pwd
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda init bash
conda activate s2p
echo 'Virtual environment activated'
./S2P/run_s2p_train.sh MMT_test_4 --epochs 2 --iters 120 --KDloss 0.1 --MMDloss 0.1 
wait
conda deactivate
echo 'python scripts have finished'
