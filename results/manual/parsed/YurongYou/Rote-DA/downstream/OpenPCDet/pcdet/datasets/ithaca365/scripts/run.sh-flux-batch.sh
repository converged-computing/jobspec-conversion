#!/bin/bash
#FLUX: --job-name=bloated-sundae-3329
#FLUX: -c=4
#FLUX: --queue=default_partition
#FLUX: --urgency=16

set -e
. /home/yy785/anaconda3/etc/profile.d/conda.sh
conda activate adaptation
set -x
cd /home/yy785/projects/adaptation/downstream/OpenPCDet/pcdet/datasets/ithaca365
${@}
