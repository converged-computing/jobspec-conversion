#!/bin/bash
#SBATCH --job-name=SCELoss
#SBATCH --account=punim0784
#SBATCH --mail-user=hanxunh@student.unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=64G
#SBATCH --time=06:00:00
#SBATCH --partition=gpgpu

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
cd /data/cephfs/punim0784/SCELoss
module load PyTorch/1.1.0-intel-2017.u2-Python-3.6.4-cuda10
nvidia-smi
python3 -u train.py   --epoch   120      \
                      --nr      0.4      \
                      --loss    SCE      \
                      >>logs/0.4nr_sce.log
