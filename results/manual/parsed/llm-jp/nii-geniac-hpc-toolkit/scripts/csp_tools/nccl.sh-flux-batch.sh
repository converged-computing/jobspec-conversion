#!/bin/bash
#FLUX: --job-name=pusheena-puppy-1346
#FLUX: --exclusive
#FLUX: -t=1200
#FLUX: --urgency=16

set -x
env | grep "SLURMD_NODENAME="
env | grep "SLURM_NODELIST="
CONTAINER_IMAGE=./nvidia+pytorch+23.10-py3.sqsh
UDS_PATH="/run/tcpx-${SLURM_JOB_ID}"
[[ "${SLURM_JOB_NUM_NODES}" -gt 1 ]] && export USE_TCPX=yes || export USE_TCPX=no
if [[ ${USE_TCPX} = "yes" ]]; then
  # Set up NCCL Environment variables
  export NCCL_NET=GPUDirectTCPX_v7
  # These network interfaces use Ubuntu's consistent naming scheme. See
  # https://manpages.ubuntu.com/manpages/focal/man7/systemd.net-naming-scheme.7.html
  export NCCL_SOCKET_IFNAME=enp0s12
  export NCCL_GPUDIRECTTCPX_CTRL_DEV=enp0s12
  export NCCL_GPUDIRECTTCPX_SOCKET_IFNAME=enp6s0,enp12s0,enp134s0,enp140s0
  export NCCL_CROSS_NIC=0
  export NCCL_ALGO=Ring
  export NCCL_PROTO=Simple
  export NCCL_NSOCKS_PERTHREAD=4
  export NCCL_SOCKET_NTHREADS=1
  export NCCL_MAX_NCHANNELS=12
  export NCCL_MIN_NCHANNELS=12
  export NCCL_DYNAMIC_CHUNK_SIZE=524288
  export NCCL_P2P_NET_CHUNKSIZE=524288
  export NCCL_P2P_PCI_CHUNKSIZE=524288
  export NCCL_P2P_NVL_CHUNKSIZE=1048576
  export NCCL_BUFFSIZE=4194304
  export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
  export NCCL_NET_GDR_LEVEL=PIX
  export NCCL_P2P_PXN_LEVEL=0
  export NCCL_GPUDIRECTTCPX_UNIX_CLIENT_PREFIX=${UDS_PATH}
  export NCCL_GPUDIRECTTCPX_PROGRAM_FLOW_STEERING_WAIT_MICROS=1000000
  export NCCL_GPUDIRECTTCPX_FORCE_ACK=0
  export NCCL_GPUDIRECTTCPX_TX_COMPLETION_NANOSLEEP=1000
  export LD_LIBRARY_PATH=/var/lib/tcpx/lib64:${LD_LIBRARY_PATH}
else
  unset NCCL_NET
fi
HOST_VARS=`sed 's/ \{1,\}/,/g' <<< "${!USE_TCPX*} ${!NCCL*} LD_LIBRARY_PATH"`;
CONTAINER_MOUNTS="/var/tmp:/var/tmp"
CONTAINER_MOUNTS=${CONTAINER_MOUNTS},"$PWD:/nccl"
if [[ ${USE_TCPX} = "yes" ]]; then
  CONTAINER_MOUNTS=${CONTAINER_MOUNTS},"/var/lib/tcpx/lib64:/var/lib/tcpx/lib64"
  CONTAINER_MOUNTS=${CONTAINER_MOUNTS},${UDS_PATH}:${UDS_PATH}
fi
srun --mpi=pmi2 \
  --cpu-bind=verbose \
  --export=ALL \
  --container-name=nccl \
  --container-image=${CONTAINER_IMAGE} \
  --container-env=${HOST_VARS} \
  --container-mounts=${CONTAINER_MOUNTS} \
  /nccl/nccl-tests/build/all_gather_perf -b 2G -e 8G -f 2 -g 1 -w 5 --iters 20
