#!/bin/bash
#FLUX: --job-name=stanky-arm-5037
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

echo START BY $USER AT `date`
nvidia-smi
module purge
module load gcc cuda cudnn python/2.7 mvapich2
source /home/$USER/venvs/atloc/bin/activate
TEMP=$TMPDIR
TEMP+="/AtLoc-master"
mkdir $TEMP
cp -r /home/$USER/cs433-atloc4topo/AtLoc-master/* $TEMP
srun python $TEMP/run.py --dataset EPFL --scene 2020-09-17-piloted --model AtLoc --data_dir $TEMP/data --logdir /home/$USER/cs433-atloc4topo/AtLoc-master/logs
wait
srun python $TEMP/train.py --dataset EPFL --scene 2020-09-17-piloted --model AtLoc --gpus 0 --data_dir $TEMP/data --logdir /home/$USER/cs433-atloc4topo/AtLoc-master/logs
wait
echo END OF $SLURM_JOB_ID AT `date`
