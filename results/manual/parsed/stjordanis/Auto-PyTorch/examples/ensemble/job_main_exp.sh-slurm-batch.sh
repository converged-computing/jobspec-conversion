#!/bin/bash
#SBATCH --job-name=apt_test
#SBATCH --output=logs/cluster/%x.%N.%j.out
#SBATCH --error=logs/cluster/%x.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=2-00:01:00
#SBATCH --partition=bosch_cpu-cascadelake
#SBATCH --array=1-3

export PYTHONPATH='$PWD'

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION"; 
source env/bin/activate
export PYTHONPATH=$PWD
if [ $SLURM_ARRAY_TASK_ID -gt 1 ]
then
    sleep 10
fi
python3 -W ignore test_ensemble.py --run_id $1 --task_id $SLURM_ARRAY_TASK_ID --num_workers 3 --dataset_id $2 --seed $3 --ensemble_setting ensemble --portfolio_type greedy --num_threads 2 --test false
echo "DONE";
echo "Finished at $(date)";
