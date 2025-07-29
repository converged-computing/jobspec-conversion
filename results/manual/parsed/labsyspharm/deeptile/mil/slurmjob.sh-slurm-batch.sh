#!/bin/bash
#SBATCH --job-name=ACAEtest
#SBATCH --output=joboutput_%j.out
#SBATCH --error=joberror_%j.err
#SBATCH --mail-user=hungyi_wu@g.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:teslaK80:1
#SBATCH --mem=32G
#SBATCH --time=00:12:00

export FP='jobresult_$SLURM_JOB_ID'

export FP="jobresult_$SLURM_JOB_ID"
mkdir $FP
module load gcc/6.2.0 python/3.6.0 cuda/10.0
source /home/hw233/virtualenv/py3/bin/activate
python test_train_MNIST.py
mv "joboutput_$SLURM_JOB_ID.out" "$FP/job.out"
mv "joberror_$SLURM_JOB_ID.err" "$FP/job.err"
