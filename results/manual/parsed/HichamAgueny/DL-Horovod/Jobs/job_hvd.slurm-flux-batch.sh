#!/bin/bash
#FLUX: --job-name=test-hdv_8gpu
#FLUX: --exclusive
#FLUX: --queue=dev-g
#FLUX: -t=900
#FLUX: --priority=16

export LC_ALL='C'
export PS1='\u@\h:\w\$ '
export LMOD_SH_DBG_ON='0'

export LC_ALL=C
export PS1="\u@\h:\w\$ "
N=$SLURM_JOB_NUM_NODES
echo "--nbr of nodes:", $N
echo "--total nbr of gpus:", $SLURM_NTASKS
ml rocm
MyProject=/project/project_465000096/hich
MyContainer=$MyProject/Container/lumi-tensorflow-rocm-5.5.1-python-3.10-tensorflow-2.11.1-horovod-0.28.1.sif
MyWD=$MyProject/TF_HVD/hvdTF_Tutorial
SRC=$MyWD/Source
Myapplication=main_hvd.py
MyJob=$MyWD/Jobs
echo
echo "------------PATHs"
echo "--Container: $MyContainer"
echo "--MyWD: $MyWD"
echo "--SRC: $SRC"
echo "--MyJob: $MyJob"
echo
MYMASKS="0x${fe}000000000000,0x${fe}00000000000000,0x${fe}0000,0x${fe}000000,0x${fe},0x${fe}00,0x${fe}00000000,0x${fe}0000000000"
MASTER_ADDR=$(scontrol show hostname "$SLURM_NODELIST" | head -n1)
rm -rf $MyJob/run-me.sh
cat > $MyJob/run-me.sh << EOF
cd $SRC
source /opt/miniconda3/bin/activate tensorflow
 # Make sure GPUs are up
  if [ \$SLURM_LOCALID -eq 0 ] ; then
    #rm -rf /dev/shm/*
    rocm-smi
    echo ""
  fi
  sleep 5
  #for each MPI process, Cray MPI strives to select a NIC device that is closest to the GPU device being used
  export MPICH_OFI_NIC_POLICY=GPU
  #To enable GPU-aware MPI
  export MPICH_GPU_SUPPORT_ENABLED=1
  export MPICH_RDMA_ENABLED_CUDA=1
  export NCCL_DEBUG=INFO
  export NCCL_DEBUG_SUBSYS=INIT,COLL,P2P,SHM,NET,ALLOC
  export NCCL_DEBUG_FILE=stdout_debug.%h.%p
  export NCCL_NET_GDR_LEVEL=SYS
  export NCCL_SOCKET_IFNAME=hsn0,hsn1,hsn2,hsn3
  export MIOPEN_USER_DB_PATH="/tmp/$(whoami)-miopen-cache-\$SLURM_NODEID"
  export MIOPEN_CUSTOM_CACHE_DIR=\$MIOPEN_USER_DB_PATH
  export CXI_FORK_SAFE=1
  export CXI_FORK_SAFE_HP=1
  export FI_CXI_DISABLE_CQ_HUGETLB=1
  # Set MIOpen cache out of the home folder.
  if [ \$SLURM_LOCALID -eq 0 ] ; then
    rm -rf \$MIOPEN_USER_DB_PATH
    mkdir -p \$MIOPEN_USER_DB_PATH
  fi
  sleep 5
  # Report affinity
  echo "Rank \$SLURM_PROCID --> \$(taskset -c -p \$\$)"
  # Uncomment to see RCCL init and collectives info 
  #export NCCL_DEBUG=INFO 
  #export NCCL_DEBUG_SUBSYS=INIT,COLL
   #python -u ${Myapplication} --batch-size=256 |& tee $MyJob/mylog-rank-\$SLURM_PROCID.log
   python -u ${Myapplication} |& tee $MyJob/mylog-rank-\$SLURM_PROCID.log
  ret=\$?
  if [ \$ret -eq 0 ] ; then
    echo ""
    echo "Rank: \$SLURM_PROCID: Success" 
  else
    echo ""
    echo "Rank: \$SLURM_PROCID: ### Fail ###!!!!" 
  fi
EOF
chmod +x $MyJob/run-me.sh
rm -rf $MyJob/mylog*
export LMOD_SH_DBG_ON=0
time srun --cpu-bind=mask_cpu:$MYMASKS \
	singularity exec \
    -B $MyJob:$PWD \
    -B $SRC \
    -B /var/spool/slurmd \
    -B /opt/cray \
    -B /usr/lib64/libcxi.so.1 \
    -B /usr/lib64/libjansson.so.4 \
     $MyContainer \
     $MyJob/run-me.sh 2>/dev/null && tee my.log
