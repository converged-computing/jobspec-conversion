#!/bin/bash
#FLUX: --job-name=expensive-ricecake-8071
#FLUX: -c=4
#FLUX: --queue=default_partition
#FLUX: -t=86400
#FLUX: --urgency=16

set -e
. /home/yy785/anaconda3/etc/profile.d/conda.sh
conda activate adaptation
set -x
cd /home/yy785/projects/adaptation/downstream/OpenPCDet/pcdet/datasets/ithaca365
${@}
