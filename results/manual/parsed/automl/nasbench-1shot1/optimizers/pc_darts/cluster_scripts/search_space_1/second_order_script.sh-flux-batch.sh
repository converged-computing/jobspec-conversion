#!/bin/bash
#FLUX: --job-name=moolicious-salad-3483
#FLUX: --priority=16

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
source ~/.bashrc
conda activate pytorch1_0_1
if [ 1 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=0 --save=unrolled --unrolled --search_space=1 --epochs=100
   exit $?
fi
if [ 2 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=1 --save=unrolled --unrolled --search_space=1 --epochs=100
   exit $?
fi
if [ 3 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=2 --save=unrolled --unrolled --search_space=1 --epochs=100
   exit $?
fi
if [ 4 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=3 --save=unrolled --unrolled --search_space=1 --epochs=100
   exit $?
fi
if [ 5 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=4 --save=unrolled --unrolled --search_space=1 --epochs=100
   exit $?
fi
if [ 6 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=5 --save=unrolled --unrolled --search_space=1 --epochs=100
   exit $?
fi
echo "DONE";
echo "Finished at $(date)";
