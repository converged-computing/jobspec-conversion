#!/bin/bash
#FLUX: --job-name=hello-lemon-3832
#FLUX: -N=4
#FLUX: -c=128
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

export CHPL_VERSION='1.25.0'
export CHPL_HOME='${PWD}/chapel-${CHPL_VERSION}'
export CHPL_LAUNCHER='none'
export CHPL_HOST_PLATFORM='linux64'
export CHPL_LLVM='none'
export CHPL_RT_NUM_THREADS_PER_LOCALE='${SLURM_CPUS_PER_TASK}'
export CHPL_COMM='gasnet'
export CHPL_COMM_SUBSTRATE='ibv'
export CHPL_TARGET_CPU='native'
export GASNET_QUIET='1'
export HFI_NO_CPUAFFINITY='1'
export GASNET_IBV_SPAWNER='ssh'
export PATH='$PATH":"$CHPL_HOME/bin/$CHPL_BIN_SUBDIR:$CHPL_HOME/util'
export GASNET_SSH_SERVERS='`scontrol show hostnames | xargs echo`'

module load toolchain/foss/2020b 
export CHPL_VERSION="1.25.0"
export CHPL_HOME="${PWD}/chapel-${CHPL_VERSION}"
export CHPL_LAUNCHER="none"
export CHPL_HOST_PLATFORM="linux64"
export CHPL_LLVM=none
export CHPL_RT_NUM_THREADS_PER_LOCALE=${SLURM_CPUS_PER_TASK}
export CHPL_COMM='gasnet'
export CHPL_COMM_SUBSTRATE='ibv'
export CHPL_TARGET_CPU='native'
export GASNET_QUIET=1
export HFI_NO_CPUAFFINITY=1
export GASNET_IBV_SPAWNER=ssh
if [ ! -d "$CHPL_HOME" ]; then
    module load devel/CMake/3.18.4-GCCcore-10.2.0
    wget -c https://github.com/chapel-lang/chapel/releases/download/1.25.0/chapel-${CHPL_VERSION}.tar.gz -O - | tar xz
    cd chapel-${CHPL_VERSION}
    make -j ${SLURM_CPUS_PER_TASK}
    cd ..
fi
CHPL_BIN_SUBDIR=`"$CHPL_HOME"/util/chplenv/chpl_bin_subdir.py`
export PATH="$PATH":"$CHPL_HOME/bin/$CHPL_BIN_SUBDIR:$CHPL_HOME/util"
export GASNET_SSH_SERVERS=`scontrol show hostnames | xargs echo`
sed -i "s/tasksPerLocale = 1/tasksPerLocale = 128/" $CHPL_HOME/examples/hello6-taskpar-dist.chpl
chpl -o hello $CHPL_HOME/examples/hello6-taskpar-dist.chpl
srun ./hello -nl ${SLURM_NNODES}
