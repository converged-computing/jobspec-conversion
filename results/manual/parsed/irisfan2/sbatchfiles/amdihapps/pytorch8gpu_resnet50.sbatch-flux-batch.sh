#!/bin/bash
#FLUX: --job-name=salted-chip-3903
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.3.0
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
source /etc/profile.d/modules.sh
module load rocm/5.2.3
module load ompi/5.0.x
module load ucx/1.13.0
singularity run /shared/apps/bin/pytorch_rocm5.2.3_ubuntu20.04_py3.7_pytorch_1.12.1.sif python3 /var/lib/jenkins/pytorch-micro-benchmarking/micro_benchmarking_pytorch.py --network resnet50 --batch-size 512 --iterations 1000  --dataparallel --device_ids 0,1,2,3,4,5,6,7
rm -rf $tmp
