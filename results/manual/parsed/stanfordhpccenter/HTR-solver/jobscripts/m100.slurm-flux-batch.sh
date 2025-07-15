#!/bin/bash
#FLUX: --job-name=prometeo
#FLUX: --priority=16

CORES_PER_NODE=32
NUMA_PER_RANK=2
RAM_PER_NODE=150000
GPUS_PER_NODE=4
FB_PER_GPU=14000
IO_THREADS="${IO_THREADS:-4}"
UTIL_THREADS="${UTIL_THREADS:-4}"
BGWORK_THREADS="${BGWORK_THREADS:-16}"
cd $SLURM_SUBMIT_DIR
source "$HTR_DIR"/jobscripts/jobscript_shared.sh
mpiexec -np "$NUM_RANKS" --map-by ppr:"$RANKS_PER_NODE":node --bind-to none \
    -x LD_LIBRARY_PATH -x HTR_DIR -x REALM_BACKTRACE -x LEGION_FREEZE_ON_ERROR \
     $COMMAND
