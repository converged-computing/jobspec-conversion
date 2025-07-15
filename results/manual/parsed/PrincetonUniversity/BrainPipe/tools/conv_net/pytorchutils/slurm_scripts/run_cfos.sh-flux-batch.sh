#!/bin/bash
#FLUX: --job-name=scruptious-signal-5959
#FLUX: --urgency=16

module load cudatoolkit/10.0 cudnn/cuda-10.0/7.3.1 anaconda3/5.3.1
. activate 3dunet
python run_cfos.py 20190607_zd_transfer_learning models/RSUNet.py samplers/soma.py augmentors/flip_rotate.py --batch_sz 500 --chkpt_num 321500 --gpus 0,1,2,3
