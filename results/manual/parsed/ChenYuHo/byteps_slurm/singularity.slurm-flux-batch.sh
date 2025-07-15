#!/bin/bash
#FLUX: --job-name=bumfuzzled-noodle-6426
#FLUX: -n=4
#FLUX: --queue=batch
#FLUX: -t=299
#FLUX: --urgency=16

export INTERFACE='ib0'
export interface_addr='$(ifconfig $INTERFACE 2>/dev/null | grep "inet " | awk '{print $2}')'
export PORT='`python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()'`'
export IMAGE='/ibex/scratch/hoc0a/byteps_horovod.sif'
export SINGULARITYENV_DMLC_ENABLE_RDMA='ibverbs'
export SINGULARITYENV_DMLC_INTERFACE='$INTERFACE'
export SINGULARITYENV_DMLC_NUM_WORKER='$NW'
export SINGULARITYENV_DMLC_NUM_SERVER='$NS'
export SINGULARITYENV_DMLC_PS_ROOT_URI='${interface_addr}'
export SINGULARITYENV_DMLC_PS_ROOT_PORT='$PORT'
export SINGULARITYENV_BYTEPS_ENABLE_IPC='0'
export SINGULARITYENV_DMLC_ROLE='scheduler'

wdir="/ibex/scratch/hoc0a/e2e-exps/byteps"
NW=${1:-$((SLURM_NTASKS/2))}
NS=${2:-$((SLURM_NTASKS-NW))}
echo $NW workers $NS servers
echo nodes: $SLURM_JOB_NODELIST
export INTERFACE=ib0
export interface_addr=$(ifconfig $INTERFACE 2>/dev/null | grep "inet " | awk '{print $2}')
export PORT=`python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()'`
export IMAGE=/ibex/scratch/hoc0a/byteps_horovod.sif
module load singularity/3.6
module load openmpi/4.0.3-cuda10.1
echo scheduler $(hostname) IP $interface_addr PORT $PORT
export SINGULARITYENV_DMLC_ENABLE_RDMA=ibverbs
export SINGULARITYENV_DMLC_INTERFACE=$INTERFACE
export SINGULARITYENV_DMLC_NUM_WORKER=$NW
export SINGULARITYENV_DMLC_NUM_SERVER=$NS
export SINGULARITYENV_DMLC_PS_ROOT_URI=${interface_addr}
export SINGULARITYENV_DMLC_PS_ROOT_PORT=$PORT
export SINGULARITYENV_BYTEPS_ENABLE_IPC=0
export SINGULARITYENV_DMLC_ROLE=scheduler
singularity exec ${IMAGE} bpslaunch &
SCHEDULER_PID=$!
mpirun -output-filename mpi_logs_$SLURM_JOB_ID -n $((NW+NS)) $wdir/bpsrun_singularity2.sh $interface_addr $PORT $NW $NS 'python /examples/tensorflow/resnet-50/benchmark.py --num-iters 10 --batch-size 32' &
SRUN_PID=$!
DELAY_SECONDS=10
while [ ! -f "$HOME/iamdone-$SLURM_JOB_ID" ];
    do
        sleep $DELAY_SECONDS
done
echo "done"
rm -f $HOME/iamdone-$SLURM_JOB_ID
kill SRUN_PID
kill SCHEDULER_PID
