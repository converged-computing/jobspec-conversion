#!/bin/bash
#FLUX: --job-name=red-buttface-4628
#FLUX: -n=6
#FLUX: -t=129600
#FLUX: --urgency=16

export PATH='/panfs/pan.fsl.byu.edu/scr/grp/fslg_hwr/env/hwr4_env:$PATH'

module purge
module load cuda/10.1
module load cudnn/7.6
export PATH="/panfs/pan.fsl.byu.edu/scr/grp/fslg_hwr/env/hwr4_env:$PATH"
cd "/panfs/pan.fsl.byu.edu/scr/grp/fslg_hwr/taylor_simple_hwr"
which python
python -u train.py --config '/panfs/pan.fsl.byu.edu/scr/grp/fslg_hwr/taylor_simple_hwr/configs/cnn_architecture/resnet.yaml'
