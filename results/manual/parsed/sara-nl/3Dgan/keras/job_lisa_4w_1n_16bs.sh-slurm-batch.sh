#!/bin/bash
#FLUX: --job-name=3DGAN_4w_1n_bs16_sun
#FLUX: --queue=test
#FLUX: -t=3600
#FLUX: --urgency=16

export KERAS_BACKEND='tensorflow'
export OMP_NUM_THREADS='$OMP_NUM_THREADS'
export KMP_AFFINITY='granularity=fine,compact,1,0'

module load Python/2.7.14-foss-2017b
ulimit -l unlimited
ulimit -s unlimited
export KERAS_BACKEND="tensorflow"
NUM_NODES=1
WORKERS_PER_SOCKET=4
INTER_T=1
NUM_SOCKETS=`lscpu | grep "Socket(s)" | cut -d':' -f2 | xargs`
CORES_PER_SOCKET=`lscpu | grep "Core(s) per socket" | cut -d':' -f2 | xargs`
CORES_PER_WORKER=$((CORES_PER_SOCKET / WORKERS_PER_SOCKET))
INTRA_T=$CORES_PER_WORKER
OMP_NUM_THREADS=4 #32 physical cores
WORKERS_PER_NODE=$((WORKERS_PER_SOCKET * NUM_SOCKETS))
TOTAL_WORKERS=$((NUM_NODES * WORKERS_PER_NODE))
echo "CORES_PER_WORKER: $CORES_PER_WORKER"
echo "NUM_INTRA_THREADS: $INTRA_T"
echo "NUM_INTER_THREADS: $INTER_T"
echo "OMP_NUM_THREADS: $OMP_NUM_THREADS"
echo "WORKERS_PER_NODE: $WORKERS_PER_NODE"
echo "TOTAL_WORKERS: $TOTAL_WORKERS"
export OMP_NUM_THREADS=$OMP_NUM_THREADS
export KMP_AFFINITY="granularity=fine,compact,1,0"
mpirun -np ${TOTAL_WORKERS} \
 --map-by socket:pe=8 \
 --bind-to core \
 --report-bindings \
 --oversubscribe \
 -x LD_LIBRARY_PATH \
 -x OMP_NUM_THREADS \
 -x KMP_AFFINITY \
 numactl -l python EcalEnergyTrain_hvd.py \
 --model EcalEnergyGan \
 --nbepochs 25 \
 --warmup 5 \
 --batchsize 16 \
 -lr 0.001 \
 --latentsize 200 \
 --optimizer=RMSprop \
 --datapath='/home/damian/cern_1.3/eos/project/d/dshep/LCD/V1/EleEscan/*.h5' \
 --weightsdir='/home/damian/cern_1.3/trained_models/CERN/3DGAN_4w_1n_bs16_sun' \
 --intraop ${INTRA_T} \
 --interop ${INTER_T}
