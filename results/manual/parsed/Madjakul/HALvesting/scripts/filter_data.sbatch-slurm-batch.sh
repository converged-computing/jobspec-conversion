#!/bin/bash
#FLUX: --job-name=threads_filter_data
#FLUX: -c=24
#FLUX: --queue=cpu_devel
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load cmake
source /home/$USER/.bashrc
conda activate halvesting
mkdir logs
./scripts/filter_data.sh
