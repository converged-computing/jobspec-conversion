#!/bin/bash
#FLUX: --job-name=tf-wavenet-stretched
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='..:$LD_LIBRARY_PATH'

source /usr/share/lmod/lmod/init/bash
module load cudnn
source ../bin/activate
export LD_LIBRARY_PATH="/farmshare/software/free/cudnn/6.0/lib64/:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="..:$LD_LIBRARY_PATH"
source train.sh
