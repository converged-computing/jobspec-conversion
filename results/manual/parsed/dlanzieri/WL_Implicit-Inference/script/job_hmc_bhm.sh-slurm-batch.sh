#!/bin/bash
#SBATCH --job-name=name_of_the_job
#SBATCH --account=ykz@v100
#SBATCH --output=name_of_the_job%j.out
#SBATCH --error=name_of_the_job%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --constraint=v100-32g,ntasks-per-node=1
#SBATCH --array=21-31

module purge
module load tensorflow-gpu/py3/2.7.0
python hmc_bhm.py  --seed=$SLURM_ARRAY_TASK_ID --filename=job_$SLURM_ARRAY_TASK_ID
