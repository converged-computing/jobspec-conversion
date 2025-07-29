#!/bin/bash
#SBATCH --job-name=rapids_dask_test_tcp
#SBATCH --output=rapids_dask_test_tcp_%j.out
#SBATCH --error=rapids_dask_test_tcp_%j.out
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=4

module load apptainer
module load cuda
SCHEDULER_DIR=$HOME/dask
WORKER_DIR=$HOME
SCRIPT=$HOME/test-cuml-Kmeans.py
if [ ! -d "$SCHEDULER_DIR" ]
then
    mkdir $SCHEDULER_DIR
fi
SCHEDULER_FILE=$SCHEDULER_DIR/my-scheduler.json
echo 'Running scheduler'
srun --nodes 1 --ntasks 1 --cpus-per-task 1\
      apptainer exec --nv $HOME/pytorch_23.05-py3.sif dask-scheduler --interface ibp65s0 \
                     --scheduler-file $SCHEDULER_FILE \
                     --no-dashboard --no-show &
sleep 10
srun --nodes 2 --ntasks 4 --cpus-per-task 1  --gpus 4 --gpus-per-task 1 \
      apptainer exec --nv $HOME/pytorch_23.05-py3.sif dask-cuda-worker --nthreads 1 --memory-limit 82GB --device-memory-limit 16GB --rmm-pool-size=15GB \
                       --interface ibp65s0 --scheduler-file $SCHEDULER_FILE --local-directory $WORKER_DIR \
                       --no-dashboard &
sleep 10
WORKERS=4
apptainer exec --nv $HOME/pytorch_23.05-py3.sif python -u $SCRIPT $SCHEDULER_FILE $WORKERS
wait
rm -fr $SCHEDULER_DIR
echo "Done!"
