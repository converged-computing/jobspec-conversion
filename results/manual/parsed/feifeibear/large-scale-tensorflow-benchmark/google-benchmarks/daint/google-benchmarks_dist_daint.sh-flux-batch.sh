#!/bin/bash
#FLUX: --job-name=dist_google_benchmark
#FLUX: -N=128
#FLUX: -t=1800
#FLUX: --urgency=16

export WORKON_HOME='~/Envs'
export ROOT_DIR='/scratch/snx3000/youyang9/fjr/tf_workspace/large-scale-tensorflow-benchmark'
export TF_SCRIPT='$ROOT_DIR/google-benchmarks/tf_cnn_benchmarks/tf_cnn_benchmarks.py'
export TF_NUM_PS='$1'
export TF_NUM_WORKERS='$2 # $SLURM_JOB_NUM_NODES'

module use /apps/daint/UES/6.0.UP02/sandbox-dl/modules/all
module load daint-gpu
module load TensorFlow/1.2.1-CrayGNU-17.08-cuda-8.0-python3
export WORKON_HOME=~/Envs
source $WORKON_HOME/tf-daint/bin/activate
export ROOT_DIR=/scratch/snx3000/youyang9/fjr/tf_workspace/large-scale-tensorflow-benchmark
export TF_SCRIPT=$ROOT_DIR/google-benchmarks/tf_cnn_benchmarks/tf_cnn_benchmarks.py
data_flags="
--num_gpus=1 \
--device=cpu \
--batch_size=32 \
--data_format=NHWC \
--variable_update=$3 \
--local_parameter_device=cpu \
--optimizer=sgd \
--model=$5 \
--data_name=imagenet \
--data_dir=/scratch/snx3000/maximem/deeplearnpackages/ImageNet/TF/
"
nodata_flags="
--num_gpus=1 \
--device=gpu \
--batch_size=32 \
--data_format=NHWC \
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
DIST_TF_LAUNCHER_DIR=$SCRATCH/fjr/tf/tf-$1-$2-$3-$4-$5
cd $DIST_TF_LAUNCHER_DIR
rm -rf .tfdist* worker.* ps.*
./run_dist_tf.sh
deactivate
