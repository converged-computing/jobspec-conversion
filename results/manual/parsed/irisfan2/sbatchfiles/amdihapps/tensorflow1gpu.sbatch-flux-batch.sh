#!/bin/bash
#FLUX: --job-name=frigid-soup-1324
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
echo "Tensorflow"
echo "1 GPU"
singularity run --env TF_ROCM_FUSION_ENABLE=1 --env PYTHONPATH=/root/.local/lib/python3.9/site-packages /shared/apps/bin/tensorflow_rocm5.2.0-tf2.9-dev2.sif python3 /root/benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py --model=resnet50  --num_gpus=1 --batch_size=256 --num_batches=100 --print_training_accuracy=True --variable_update=parameter_server --local_parameter_device=gpu
