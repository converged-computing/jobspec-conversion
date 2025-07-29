#!/bin/bash
#SBATCH --job-name=w_mor
#SBATCH --account=colina
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --mail-user=some_user@some_domain.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=25gb
#SBATCH --time=7-00:00:00
#SBATCH --qos=colina

ml cuda/10.0.130 namd/3.0
cd $SLURM_SUBMIT_DIR
/apps/cuda/11.0.207/base/namd/3.0/NAMD_3.0alpha7_Linux-x86_64-multicore-CUDA/namd3 step7_production4.inp>step7_production4.log
/apps/cuda/11.0.207/base/namd/3.0/NAMD_3.0alpha7_Linux-x86_64-multicore-CUDA/namd3 step7_production5.inp>step7_production5.log
