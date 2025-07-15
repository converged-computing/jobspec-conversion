#!/bin/bash
#FLUX: --job-name=conspicuous-punk-9798
#FLUX: -c=4
#FLUX: --queue=default_partition --gres=gpu:0
#FLUX: --priority=16

set -e
. /home/yy785/anaconda3/etc/profile.d/conda.sh
conda activate adaptation
set -x
cd /home/yy785/projects/adaptation/downstream/OpenPCDet/pcdet/datasets/ithaca365
${@}
