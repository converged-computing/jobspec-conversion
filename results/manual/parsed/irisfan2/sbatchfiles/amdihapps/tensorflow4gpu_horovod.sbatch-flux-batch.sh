#!/bin/bash
#FLUX: --job-name=ornery-carrot-6259
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
echo "Tensorflow Horovod"
echo "4 GPU"
singularity run --env PYTHONPATH=/root/.local/lib/python3.9/site-packages /shared/apps/bin/tensorflow_rocm5.2.0-tf2.9-dev2.sif /usr/local/bin/horovodrun -np 4 -H localhost:4 python3 /root/benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py --model resnet101 --batch_size 64 --variable_update horovod
