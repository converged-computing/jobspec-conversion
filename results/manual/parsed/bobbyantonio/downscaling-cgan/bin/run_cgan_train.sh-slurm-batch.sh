#!/bin/bash
#SBATCH --job-name=cgan-train
#SBATCH --output=logs/cgan-train-%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:A100:1
#SBATCH --mem=300gb
#SBATCH --time=8-00:00:00
#SBATCH --constraint=ntasks-per-node=1

source ~/.bashrc
source ~/.initConda.sh
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Slurm job ID is $SLURM_JOBID
echo This jobs runs on the following machines:
echo $SLURM_JOB_NODELIST
nvidia-smi --query-gpu=gpu_name,driver_version,memory.free,memory.total --format=csv
nvidia-smi
module load lang/cuda/11.2-cudnn-8.1
nvidia-smi
echo "running model"
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt"
srun python -m dsrnngan.main --eval-blitz --num-samples 320000 --restart --records-folder /user/work/uz22147/tfrecords/998e5f0f54106b35 --model-config-path /user/home/uz22147/repos/downscaling-cgan/config/model_config_medium-cl100_crop100.yaml --output-suffix medium-cl100-nologs-crop100 --num-images 2900 --eval-ensemble-size 1 --no-shuffle-eval;
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt"
