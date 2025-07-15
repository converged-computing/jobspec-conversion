#!/bin/bash
#FLUX: --job-name=expensive-frito-6836
#FLUX: --urgency=16

export OMP_NUM_THREADS='66'

module load tensorflow/intel-head
export OMP_NUM_THREADS=66
KMP_AFFINITY="granularity=fine,noverbose,compact,1,0"
KMP_SETTINGS=1
KMP_BLOCKTIME=1
SCRIPT_DIR=/global/cscratch1/sd/yyang420/fjr/tensorflow/distributed-tensorflow-benchmarks/google-benchmarks
cd $SCRIPT_DIR
srun -n 1 -N 1 -c 272 python tf_cnn_benchmarks/tf_cnn_benchmarks.py \
--num_gpus=1 \
--batch_size=64 \
--num_warmup_batches=2 \
--num_batches=10 \
--data_format=NCHW \
--variable_update=parameter_server \
--local_parameter_device=cpu \
--device=cpu \
--optimizer=sgd \
--model=inception3 \
--data_name=imagenet
