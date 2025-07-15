#!/bin/bash
#FLUX: --job-name=cgan-train
#FLUX: -c=16
#FLUX: --queue=cnu
#FLUX: -t=691200
#FLUX: --priority=16

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
