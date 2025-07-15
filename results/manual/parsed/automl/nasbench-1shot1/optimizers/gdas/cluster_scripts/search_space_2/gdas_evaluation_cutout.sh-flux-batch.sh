#!/bin/bash
#FLUX: --job-name=misunderstood-bicycle-1361
#FLUX: --priority=16

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
source ~/.bashrc
conda activate pytorch1_0_1
if [ 1 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=10 --search_space=2 --cutout
   exit $?
fi
if [ 2 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=14 --search_space=2 --cutout
   exit $?
fi
if [ 3 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=15 --search_space=2 --cutout
   exit $?
fi
if [ 4 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=16 --search_space=2 --cutout
   exit $?
fi
if [ 5 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=17 --search_space=2 --cutout
   exit $?
fi
if [ 6 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=18 --search_space=2 --cutout
   exit $?
fi
if [ 7 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=19 --search_space=2 --cutout
   exit $?
fi
if [ 8 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=20 --search_space=2 --cutout
   exit $?
fi
if [ 9 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=23 --search_space=2 --cutout
   exit $?
fi
if [ 10 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=24 --search_space=2 --cutout
   exit $?
fi
if [ 11 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=21 --search_space=2 --cutout
   exit $?
fi
if [ 12 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/gdas/train_search.py --save=first_order_cutout --seed=22 --search_space=2 --cutout
   exit $?
fi
echo "DONE";
echo "Finished at $(date)";
