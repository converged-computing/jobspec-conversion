#!/bin/bash
#FLUX: --job-name=parse
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/path/to/this/repo/structural_DLFA/parsers'

nSchedulerCores=20
nClientCores=1
nWorkerCores=1	# should be a factor of 32 to ensure all available resources are utilized and no workers are spread across two compute nodes
WorkingDirName=example
date
PrimaryNode=$(echo $(scontrol show hostnames $SLURM_JOB_NODELIST) | awk '{print $1;}')
__conda_setup="$('/ccs/home/davidsonrb/Apps/miniconda3_ANDES/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/ccs/home/davidsonrb/Apps/miniconda3_ANDES/etc/profile.d/conda.sh" ]; then
        . "/ccs/home/davidsonrb/Apps/miniconda3_ANDES/etc/profile.d/conda.sh"
    else
        export PATH="/ccs/home/davidsonrb/Apps/miniconda3_ANDES/bin:$PATH"
    fi
fi
unset __conda_setup
conda activate openmm_andes
export PYTHONPATH=$PYTHONPATH:/path/to/this/repo/structural_DLFA/parsers
RUN_DIR=/path/to/a/results/directory/$WorkingDirName
SCHEDULER_FILE=${RUN_DIR}/scheduler_file.json
SRC_DIR=/path/to/this/repo/structural_DLFA/scripts
if [ ! -d "$RUN_DIR" ]
then
    mkdir -p $RUN_DIR
fi
cd $RUN_DIR
let x=$SLURM_CPUS_ON_NODE y=$nSchedulerCores z=$nClientCores nAvailCores=x-y-z	# subtracting the scheduler and client from the available cores; use this value for spinning up workers on the primary/head node
let x=$nAvailCores y=$nWorkerCores nWorkersPrimary=x/y	# returns an integer value, rounded down; if 0, then no workers will be spun up on primary node
let x=$SLURM_JOB_NUM_NODES y=1 nNodes=x-y		# remove the primary/head node from further math
let x=$nNodes y=$SLURM_CPUS_ON_NODE z=$nWorkerCores nWorkers=x*y/z	# calculating the total number of workers to be spun up by srun; excluding workers spun up on the primary/head node
let x=$nWorkersPrimary y=$nWorkers totalWorkers=x+y	# just for printing;
echo "################################################################################"
echo "Using python: " `which python3`
echo "PYTHONPATH: " $PYTHONPATH
echo "SRC_DIR: " $SRC_DIR
echo "Scheduler file:" $SCHEDULER_FILE
echo "Workflow running on" $SLURM_JOB_NUM_NODES "nodes"
echo "Primary/Head node is" $PrimaryNode
echo "Scheduler given" $nSchedulerCores "core(s) on the Primary/Head node"
echo "Client given" $nClientCores "core(s) on the Primary/Head node"
echo $totalWorkers "workers are spun up with" $nWorkerCores "core(s) per worker"
echo "################################################################################"
dask_pids=""
echo "Spinning up the dask-scheduler"
srun -n 1 -N 1 -c $nSchedulerCores --cpu-bind=threads -w $PrimaryNode \
	dask-scheduler --interface ib0 --no-dashboard --no-show --scheduler-file $SCHEDULER_FILE  > dask_scheduler.out 2>&1 &
dask_pids="$dask_pids $!"
if [ $nWorkersPrimary -ne 0 ]; then
	echo "Spinning $nWorkersPrimary workers up on the head node, each getting $nWorkerCores" cores
	srun -n $nWorkersPrimary -N 1 -c $nWorkerCores --cpu-bind=threads -w $PrimaryNode \
		dask-worker --nthreads 1 --nworkers 1 --interface ib0 --no-dashboard --no-nanny --reconnect --scheduler-file ${SCHEDULER_FILE} > dask_worker.out 2>&1 &	
	dask_pids="$dask_pids $!"
fi
if [ $nWorkers -ne 0 ]; then
	echo "Spinning $nWorkers workers up on non-head node(s), each getting $nWorkerCores" cores
	srun -n $nWorkers -N $nNodes -c $nWorkerCores --cpu-bind=threads \
		dask-worker --nthreads 1 --nworkers 1 --interface ib0 --no-dashboard --no-nanny --reconnect --scheduler-file ${SCHEDULER_FILE} > dask_worker.out 2>&1 &	
	dask_pids="$dask_pids $!"
fi
echo "Running the client script"
srun -n 1 -N 1 -c $nClientCores --cpu-bind=threads -w $PrimaryNode \
	python3 ${SRC_DIR}/annotation_pipeline.py --scheduler-file $SCHEDULER_FILE \
					  --input-list-file ${SRC_DIR}/testing.lst \
					  --output-dir ${RUN_DIR} \
					  --timings-file timings.csv \
					  --tskmgr-log-file tskmgr.log \
					  --tmscore-threshold 0.6
for pid in $dask_pids
do
        kill $pid
done
echo Run finished.
date
