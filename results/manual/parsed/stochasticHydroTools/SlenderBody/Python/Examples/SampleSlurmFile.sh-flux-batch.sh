#!/bin/bash
#FLUX: --job-name=BundleRigFl
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load python/intel/3.8.6
module load cuda/11.6.2
module load onetbb/intel/2021.1.1
cd SlenderBody/Examples
python FixedDynamicLinkNetwork.py $SLURM_ARRAY_TASK_ID 0.00005 2
