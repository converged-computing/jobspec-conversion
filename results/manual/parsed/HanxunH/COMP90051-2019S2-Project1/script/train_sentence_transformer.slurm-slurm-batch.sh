#!/bin/bash
#SBATCH --job-name=51
#SBATCH --account=punim0784
#SBATCH --mail-user=hanxunh@student.unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=64G
#SBATCH --time=1-23:59:00

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
cd /data/cephfs/punim0784/nas_research//COMP90051-Project1/
module load Python/3.5.2-intel-2017.u2-GCC-5.4.0-CUDA9
nvidia-smi
python3 -u train_sentence_transformers.py
