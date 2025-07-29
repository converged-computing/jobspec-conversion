#!/bin/bash
#SBATCH --job-name=subpex_1
#SBATCH --output=job_logs/slurm.out
#SBATCH --error=job_logs/slurm.err
#SBATCH --mail-user=user@email.domain
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=opa-high-mem
#SBATCH --constraint=ntasks-per-node=28

source env.sh
SERVER_INFO=$WEST_SIM_ROOT/west_zmq_info-$SLURM_JOBID.json
echo $WEST_PYTHON
w_run --work-manager=zmq --n-workers=0 --zmq-mode=master --zmq-write-host-info=$SERVER_INFO --zmq-comm-mode=tcp &> ./job_logs/west-$SLURM_JOBID.log &
for ((n=0; n<60; n++)); do
    if [ -e $SERVER_INFO ] ; then
        echo "== server info file $SERVER_INFO =="
        cat $SERVER_INFO
        break
    fi
    sleep 1
done
if ! [ -e $SERVER_INFO ] ; then
    echo 'server failed to start'
    exit 1
fi
scontrol show hostname $SLURM_NODELIST > slurm_nodelist.txt
for node in $(scontrol show hostname $SLURM_NODELIST); do
    ssh -o StrictHostKeyChecking=no $node $PWD/node.sh $SLURM_SUBMIT_DIR $SLURM_JOBID $node $CUDA_VISIBLE_DEVICES --work-manager=zmq --n-workers=1 --zmq-mode=client --zmq-read-host-info=$SERVER_INFO --zmq-comm-mode=tcp &
done
wait
