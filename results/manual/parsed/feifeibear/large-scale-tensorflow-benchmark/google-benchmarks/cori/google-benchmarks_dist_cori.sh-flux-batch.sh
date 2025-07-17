#!/bin/bash
#FLUX: --job-name=dist
#FLUX: -N=128
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='66'
export TF_SCRIPT='/global/cscratch1/sd/yyang420/fjr/tensorflow/distributed-tensorflow-benchmarks/google-benchmarks/tf_cnn_benchmarks/tf_cnn_benchmarks.py'
export TF_NUM_PS='$1'
export TF_NUM_WORKERS='$2 # $SLURM_JOB_NUM_NODES'
export TF_PS_IN_WORKER='true'

module load tensorflow/intel-head
export OMP_NUM_THREADS=66
KMP_AFFINITY="granularity=fine,noverbose,compact,1,0"
KMP_SETTINGS=1
KMP_BLOCKTIME=1
export TF_SCRIPT="/global/cscratch1/sd/yyang420/fjr/tensorflow/distributed-tensorflow-benchmarks/google-benchmarks/tf_cnn_benchmarks/tf_cnn_benchmarks.py"
data_flags="
"
nodata_flags="
--num_gpus=1 \
--device=cpu \
--batch_size=32 \
--data_format=NCHW \
--kmp_blocktime=1 \
--kmp_settings=1 \
--mkl=true \
--num_inter_threads=2 \
--num_intra_threads=66 \
--variable_update=$3 \
--local_parameter_device=cpu \
--optimizer=sgd \
--model=$5 \
--data_name=imagenet
"
if [ "$4" = "true" ]; then
  export TF_FLAGS=$data_flags
elif [ "$4" = "false" ]; then
  export TF_FLAGS=$nodata_flags
else
  echo "error in real_data argument"
  exit 1
fi
export TF_NUM_PS=$1
export TF_NUM_WORKERS=$2 # $SLURM_JOB_NUM_NODES
export TF_PS_IN_WORKER=true
cd /global/cscratch1/sd/yyang420/fjr/tf/tf-$1-$2-$3-$4-$5
rm -rf .tfdist* worker.* ps.*
./run_dist_tf.sh
