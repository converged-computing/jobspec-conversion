#!/bin/bash
#FLUX: --job-name=conspicuous-cinnamonbun-7166
#FLUX: --priority=16

export PYTHONPATH='${PYTHONPATH}:/lustre/orion/ast181/proj-shared/rcaddy/JSI_Workshop_Talk_2023/python'
export PATH='/ccs/home/rcaddy/miniconda_crusher/bin:$PATH'

DASK_SCHEDULE_FILE=/lustre/orion/ast181/proj-shared/rcaddy/JSI_Workshop_Talk_2023/data/otv_full_scale/dask_schedule_file.json
DASK_NUM_WORKERS=$((SLURM_JOB_NUM_NODES*8))
export PYTHONPATH="${PYTHONPATH}:/lustre/orion/ast181/proj-shared/rcaddy/JSI_Workshop_Talk_2023/python"
export PATH="/ccs/home/rcaddy/miniconda_crusher/bin:$PATH"
source activate /ccs/proj/ast181/rcaddy/conda-envs/crusher/py-3.11
conda env list
INTERFACE='' # For Crusher
srun --exclusive --ntasks=1 dask scheduler $INTERFACE --scheduler-file $DASK_SCHEDULE_FILE --no-dashboard --no-show &
sleep 30
srun --exclusive --ntasks=$DASK_NUM_WORKERS dask worker --scheduler-file $DASK_SCHEDULE_FILE --memory-limit='auto' --worker-class distributed.Worker $INTERFACE --no-dashboard --local-directory /ccs/home/rcaddy/ast181-orion/proj-shared/rcaddy/JSI_Workshop_Talk_2023/data/otv_full_scale/dask-scratch-space &
sleep 30
python -u ./dask-andes-runner.py --scheduler-file $DASK_SCHEDULE_FILE --num-workers $DASK_NUM_WORKERS --num-ranks=196 --gen-images=True --gen-video=True
wait
