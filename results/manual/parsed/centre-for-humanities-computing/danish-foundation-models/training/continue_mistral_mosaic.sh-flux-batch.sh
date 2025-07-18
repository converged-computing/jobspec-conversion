#!/bin/bash
#FLUX: --job-name=purple-fudge-2154
#FLUX: -c=56
#FLUX: --exclusive
#FLUX: --queue=standard-g
#FLUX: -t=3600
#FLUX: --urgency=16

export SINGULARITYENV_LD_LIBRARY_PATH='/opt/ompi/lib:${EBROOTAWSMINOFIMINRCCL}/lib:/opt/cray/xpmem/2.5.2-2.4_3.47__gd0f7936.shasta/lib64:/opt/aws-ofi-rccl/lib:${SINGULARITYENV_LD_LIBRARY_PATH}'
export SINGULARITY_BIND='$(echo $SINGULARITY_BIND | sed 's|,/usr/lib64/libssh.so.4||g') # do not bind host libssh which is built against a wrong libssl for some reason'
export LC_ALL='C'
export HF_DATASETS_CACHE='/scratch/project_465000670/.cache/huggingface" '
export TRANSFORMERS_CACHE='/scratch/project_465000670/.cache/huggingface'
export NODE_RANK='$SLURM_NODEID'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_PORT='9999'
export WORLD_SIZE='$(($GPUS_PER_NODE*$NNODES))'
export CC='gcc-11'
export CXX='g++-11'

if [ -z $SLURM_JOB_ID ]; then
    mkdir -p logs
    sbatch "$0"
    exit
fi
module load LUMI/22.08 partition/G
local_libfabric_version=1.15.2.0
local_craympich_version=8.1.27
export SINGULARITYENV_LD_LIBRARY_PATH="/lib64:/opt/cray/pe/mpich/$local_craympich_version/ofi/gnu/9.1/lib-abi-mpich:/opt/cray/pe/lib64:/opt/cray/pe:/opt/cray/libfabric/$local_libfabric_version/lib64:/usr/lib64:/opt/cray/pe/gcc-libs:${SINGULARITYENV_LD_LIBRARY_PATH}"
export SINGULARITY_BIND="/opt/cray,/usr/lib64/libbrotlidec.so.1,/usr/lib64/libbrotlicommon.so.1,/usr/lib64/libnl-3.so.200,/usr/lib64/libnl-route-3.so.200,/usr/lib64/libcxi.so.1,/usr/lib64/libcurl.so.4,/usr/lib64/libnghttp2.so.14,/usr/lib64/libidn2.so.0,/usr/lib64/libssh.so.4,/usr/lib64/libpsl.so.5,/usr/lib64/libssl.so.1.1,/usr/lib64/libcrypto.so.1.1,/usr/lib64/libgssapi_krb5.so.2,/usr/lib64/libldap_r-2.4.so.2,/usr/lib64/liblber-2.4.so.2,/usr/lib64/libjson-c.so.3,/usr/lib64/libunistring.so.2,/usr/lib64/libkrb5.so.3,/usr/lib64/libk5crypto.so.3,/usr/lib64/libkrb5support.so.0,/usr/lib64/libsasl2.so.3,/usr/lib64/libkeyutils.so.1,/var/spool/slurmd/mpi_cray_shasta,/usr/lib64/libzstd.so.1,/lib64/libselinux.so.1,/usr/lib64/libpcre.so.1,${SINGULARITY_BIND}"
export SINGULARITY_BIND=/users/larsenra/aws-ofi-rccl/install:/opt/aws-ofi-rccl,/usr/lib64/libjitterentropy.so.3,${SINGULARITY_BIND}
export SINGULARITYENV_LD_LIBRARY_PATH=/opt/ompi/lib:${EBROOTAWSMINOFIMINRCCL}/lib:/opt/cray/xpmem/2.5.2-2.4_3.47__gd0f7936.shasta/lib64:/opt/aws-ofi-rccl/lib:${SINGULARITYENV_LD_LIBRARY_PATH}
export SINGULARITY_BIND=$(echo $SINGULARITY_BIND | sed 's|,/usr/lib64/libssh.so.4||g') # do not bind host libssh which is built against a wrong libssl for some reason
export LC_ALL=C
export HF_DATASETS_CACHE="/scratch/project_465000670/.cache/huggingface" 
export TRANSFORMERS_CACHE="/scratch/project_465000670/.cache/huggingface"
GPUS_PER_NODE=$SLURM_GPUS_PER_NODE
NNODES=$SLURM_NNODES
export NODE_RANK=$SLURM_NODEID
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_PORT=9999
export WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))
export CC=gcc-11
export CXX=g++-11
CONTAINER="/project/project_465000670/pytorch_rocm5.7_ubuntu22.04_py3.10_pytorch_2.0.1.sif"
SING_BIND="/scratch/project_465000670"
rm -rf separate-logs
mkdir -p separate-logs
set -exuo pipefail
ln -f -s $SLURM_JOB_ID.out logs/latest.out
ln -f -s $SLURM_JOB_ID.err logs/latest.err
CHECKPOINT_PATH=checkpoints
CMD=" \
    llm-foundry/scripts/train/train.py \
    yamls/continue-mistral-7b.yaml
    "
c=fe
BIND_MASK_1="0x${c}000000000000,0x${c}00000000000000,0x${c}0000,0x${c}000000,0x${c},0x${c}00,0x${c}00000000,0x${c}0000000000"
BIND_MASK_2="0x${c}00000000000000${c}000000000000,0x${c}00000000000000${c}00000000000000,0x${c}00000000000000${c}0000,0x${c}00000000000000${c}000000,0x${c}00000000000000${c},0x${c}00000000000000${c}00,0x${c}00000000000000${c}00000000,0x${c}00000000000000${c}0000000000"
BIND_MASK="$BIND_MASK_1"
echo $CMD
echo "START $SLURM_JOBID: $(date)"
srun \
    --label \
    singularity exec -B "$SING_BIND" "$CONTAINER" \
    /scratch/project_465000670/danish-foundation-models/training/mosaic_in_container.sh \
    $CMD
echo "END $SLURM_JOBID: $(date)"
