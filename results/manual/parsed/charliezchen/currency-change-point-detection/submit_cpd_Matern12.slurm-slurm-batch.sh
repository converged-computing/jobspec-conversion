#!/bin/bash
#FLUX: --job-name=cpd_Matern
#FLUX: -t=82800
#FLUX: --urgency=16

singularity exec --overlay $SCRATCH/overlay-25GB-500K.ext3:ro /scratch/work/public/singularity/cuda10.1-cudnn7-devel-ubuntu18.04-20201207.sif /bin/bash -c '
echo "Running cpd_module"
source /ext3/env.sh
conda activate base
python3 -m examples.concurent_cpd_quandl 21 --kernel Matern12
'
