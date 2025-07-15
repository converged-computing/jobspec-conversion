#!/bin/bash
#FLUX: --job-name=strawberry-fork-1993
#FLUX: --priority=16

DIR=$PWD
TESTDIR=$DW_JOB_STRIPED
TRANSFER_SIZE=1MiB
BLOCK_SIZE=100MiB
RANKS_PER_NODE=32
NODES=$SLURM_JOB_NUM_NODES
RANKS=$(( $NODES*$RANKS_PER_NODE ))
OPTIONS="-g -t $TRANSFER_SIZE -b $BLOCK_SIZE -o ${TESTDIR}/IOR_file -v"
BASE=$DIR/mssf_${TRANSFER_SIZE}_${BLOCK_SIZE}_${NODES}nodes_${RANKS}files_wlmpool${DWN}_${SLURM_JOBID}
print ${BASE}
print ${RANKS}
print "   ", ${OPTIONS}
time srun -n ${RANKS} --ntasks-per-node=${RANKS_PER_NODE} ./IOR -a MPIIO ${OPTIONS} < /dev/null >> ${BASE}.IOR
BASE=$DIR/pfpp_${TRANSFER_SIZE}_${BLOCK_SIZE}_${NODES}nodes_${RANKS}files_wlmpool${DWN}_${SLURM_JOBID}
print ${BASE}
time srun -n ${RANKS} --ntasks-per-node=${RANKS_PER_NODE} ./IOR -a POSIX -F -e ${OPTIONS} < /dev/null >> ${BASE}.IOR
