#!/bin/bash
#FLUX: --job-name=gloopy-lemur-5809
#FLUX: --priority=16

export SRC_DIR='/ccs/home/gunaratnecs/sagesim/examples/sir'
export SCHEDULER_FILE='${RUN_DIR}/scheduler_file.json'
export PATH='/gpfs/alpine/csc505/proj-shared/conda_sagesim_hpc/bin:$PATH'

export SRC_DIR=/ccs/home/gunaratnecs/sagesim/examples/sir
RUN_DIR=/gpfs/alpine/proj-shared/lrn047/chathika/runs/sagesim_debug/${LSB_JOBID}
if [ ! -d "$RUN_DIR" ]
then
	mkdir -p $RUN_DIR
fi
cd $RUN_DIR
export SCHEDULER_FILE=${RUN_DIR}/scheduler_file.json
module load ums
module load ums-gen119
module load nvidia-rapids/21.08
conda activate /gpfs/alpine/csc505/proj-shared/conda_sagesim_hpc
export PATH=/gpfs/alpine/csc505/proj-shared/conda_sagesim_hpc/bin:$PATH
PYTHONPATH=${SRC_DIR}:$PYTHONPATH
jsrun  --smpiargs="-disable_gpu_hooks"  --nrs 1 --tasks_per_rs 1 --cpu_per_rs 1  dask-scheduler  --interface ib0 --no-dashboard --no-show \
  --scheduler-file $SCHEDULER_FILE > dask-scheduler.out 2>&1 &
sleep 10
Start_Workers() {
    for gpu in $(seq 0 5); do
        echo Setting up for GPU rank $gpu on $(hostname) ;
        (env -v CUDA_VISIBLE_DEVICES=${gpu} \
            dask worker \
            --scheduler-file $SCHEDULER_FILE --local-directory /tmp \--name worker-$(hostname)-gpu${gpu} --nthreads 2 --nworkers 1 \
            --no-dashboard --no-nanny --death-timeout 600) &
        sleep 2 ;
    done
}
jsrun -h $RUN_DIR \
  --smpiargs="-disable_gpu_hooks" \
  --tasks_per_rs 1 --cpu_per_rs 2 --gpu_per_rs 1 --rs_per_host 6 \
    Start_Workers &
sleep 5
python -u $SRC_DIR/run.py
wait
rm -fr $SCHEDULER_DIR $SCHEDULER_FILE
echo "Done!"
bkill $LSB_JOBID
