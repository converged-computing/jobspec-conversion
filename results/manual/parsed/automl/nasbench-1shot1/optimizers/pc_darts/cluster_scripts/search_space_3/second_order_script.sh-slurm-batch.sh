#!/bin/bash
#SBATCH --job-name=DARTS_NASBENCH
#SBATCH --output=log/log_$USER_%Y-%m-%d.out
#SBATCH --error=log/err_$USER_%Y-%m-%d.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=10000
#SBATCH --time=11-00:00:00
#SBATCH --partition=bosch_gpu-rtx2080
#SBATCH --chdir=/home/siemsj/projects/darts/cnn
#SBATCH --array=1-6

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
source ~/.bashrc
conda activate pytorch1_0_1
if [ 1 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=0 --save=unrolled --unrolled --search_space=3 --epochs=100
   exit $?
fi
if [ 2 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=1 --save=unrolled --unrolled --search_space=3 --epochs=100
   exit $?
fi
if [ 3 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=2 --save=unrolled --unrolled --search_space=3 --epochs=100
   exit $?
fi
if [ 4 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=3 --save=unrolled --unrolled --search_space=3 --epochs=100
   exit $?
fi
if [ 5 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=4 --save=unrolled --unrolled --search_space=3 --epochs=100
   exit $?
fi
if [ 6 -eq $SLURM_ARRAY_TASK_ID ]; then
   PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=5 --save=unrolled --unrolled --search_space=3 --epochs=100
   exit $?
fi
echo "DONE";
echo "Finished at $(date)";
