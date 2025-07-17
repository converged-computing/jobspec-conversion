#!/bin/bash
#FLUX: --job-name=ci-jax-gpu
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=compute
#FLUX: -t=900
#FLUX: --urgency=16

set -x
CONTAINER="nvcr.io/nvidian/jax_t5x:cuda11.4-cudnn8.2-ubuntu20.04-manylinux2014-multipython"
CONTAINER_NAME="multinode_ci_test_container"
BASE_WORKSPACE_DIR=$GITHUB_WORKSPACE
WORKSPACE_DIR=/workspace
MOUNTS="--container-mounts=$BASE_WORKSPACE_DIR:/$WORKSPACE_DIR"
EXPORTS="--export=ALL,NCCL_SOCKET_IFNAME=enp45s0f0,NCCL_SOCKET_NTHREADS=2,NCCL_NSOCKS_PERTHREAD=2"
read -r -d '' setup_cmd <<EOF
python3.8 -m pip install --pre jaxlib -f https://storage.googleapis.com/jax-releases/jaxlib_nightly_cuda_releases.html \
&& python3.8 -m pip install git+https://github.com/google/jax \
&& python3.8 -m pip install pytest \
&& mkdir -p /workspace/outputs/
EOF
read -r -d '' cmd <<EOF
date \
&& python3.8 -m pip  list | grep jax \
&& python3.8 -m pytest -v  -s --continue-on-collection-errors \
    --junit-xml=/workspace/outputs/junit_output_\${SLURM_PROCID}.xml \
    /workspace/tests/distributed_multinode_test.py
EOF
OUTPUT_DIR="${BASE_WORKSPACE_DIR}/outputs/"
mkdir -p $OUTPUT_DIR
OUTFILE="${OUTPUT_DIR}/output-%j-%n.txt"
echo $setup_cmd
srun -o $OUTFILE -e $OUTFILE \
    --container-writable \
    --container-image="$CONTAINER" \
    --container-name=$CONTAINER_NAME \
    $MOUNTS  \
    $EXPORTS \
    bash -c "${setup_cmd}"
wait
echo $cmd
srun -o $OUTFILE -e $OUTFILE \
    --open-mode=append \
    --container-writable \
    --container-image="$CONTAINER" \
    --container-name=$CONTAINER_NAME \
    $MOUNTS  \
    $EXPORTS \
    bash -c "${cmd}"
set +x
