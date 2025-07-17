#!/bin/bash
#FLUX: --job-name=ornery-butter-2615
#FLUX: -c=16
#FLUX: --gpus-per-task=1
#FLUX: -t=60
#FLUX: --urgency=16

export PMI_MAX_KVS_ENTRIES='128'
export LCI_ENABLE_PRG_NET_ENDPOINT='0'

module purge
module load octotiger
module list
OCTO_SCRIPT_PATH=${OCTO_SCRIPT_PATH:-/global/homes/j/jackyan/workspace/octotiger-scripts}
cd ${OCTO_SCRIPT_PATH}/data || exit 1
task=${1:-"rs"}
pp=${2:-"lci"}
max_level=${3:-"3"}
if [ "$pp" == "lci" ] ; then
  export LCI_SERVER_MAX_SENDS=256
  export LCI_SERVER_MAX_RECVS=4096
  export LCI_SERVER_NUM_PKTS=65536
  export LCI_SERVER_MAX_CQES=8192
  export LCI_PACKET_SIZE=65536
fi
SRUN_EXTRA_OPTION=""
export PMI_MAX_KVS_ENTRIES=128
date
echo "run $task with parcelport $pp; max_level=${max_level}"
export LCI_ENABLE_PRG_NET_ENDPOINT=0
if [ "$task" = "rs" ] ; then
	srun ${SRUN_EXTRA_OPTION} octotiger \
        --hpx:ini=hpx.stacks.use_guard_pages!=0 \
        --hpx:ini=hpx.parcel.${pp}.priority=1000 \
        --hpx:ini=hpx.parcel.${pp}.zero_copy_serialization_threshold=8192 \
        --config_file=${OCTO_SCRIPT_PATH}/data/rotating_star.ini \
        --max_level=${max_level} \
        --stop_step=5 \
        --theta=0.34 \
        --correct_am_hydro=0 \
        --disable_output=on \
        --max_executor_slices=8 \
        --cuda_streams_per_gpu=32 \
        --monopole_host_kernel_type=DEVICE_ONLY \
        --multipole_host_kernel_type=DEVICE_ONLY \
        --monopole_device_kernel_type=CUDA \
        --multipole_device_kernel_type=CUDA \
        --hydro_device_kernel_type=CUDA \
        --hydro_host_kernel_type=DEVICE_ONLY \
        --amr_boundary_kernel_type=AMR_OPTIMIZED \
        --hpx:threads=16 \
        --hpx:ini=hpx.parcel.lci.protocol=putva \
        --hpx:ini=hpx.agas.use_caching=0 \
        --hpx:ini=hpx.parcel.lci.progress_type=rp \
        --hpx:ini=hpx.parcel.lci.ndevices=1 \
        --hpx:ini=hpx.parcel.lci.prg_thread_num=1
fi
