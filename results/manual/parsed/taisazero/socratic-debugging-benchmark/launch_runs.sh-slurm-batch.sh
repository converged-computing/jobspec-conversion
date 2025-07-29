#!/bin/bash
#SBATCH --job-name=socratic_exp
#SBATCH --output=%j.o
#SBATCH --error=%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=30gb
#SBATCH --time=1-00:00:00
#SBATCH --partition=GPU
#SBATCH --constraint=ntasks-per-node=16

source activate socratic_env
echo "loaded module"
cd $SLURM_SUBMIT_DIR
mkdir -p job_logs
echo "running code"
python -u run_socratic_benchmark_metrics.py --generation_mode multiple
echo "finished running"
cd $SLURM_SUBMIT_DIR
mv $SLURM_JOB_ID.o job_logs/$SLURM_JOB_ID.o
mv $SLURM_JOB_ID.e job_logs/$SLURM_JOB_ID.e
