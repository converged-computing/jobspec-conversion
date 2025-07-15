#!/bin/bash
#FLUX: --job-name=conspicuous-animal-1057
#FLUX: --queue=gpu
#FLUX: -t=3600
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
srun python $TEMP/run.py --dataset comballaz --scene air --model AtLoc --data_dir $TEMP/data --logdir /home/$USER/cs433-atloc4topo/AtLoc-master/logs
wait
srun python $TEMP/eval.py --dataset comballaz --scene air --model AtLoc --gpus 0 --data_dir $TEMP/data --weights /home/$USER/cs433-atloc4topo/AtLoc-master/logs/comballaz_air_AtLoc_False/models/epoch_085.pth.tar --logdir /home/$USER/cs433-atloc4topo/AtLoc-master/logs 
wait
srun python $TEMP/run.py --dataset comballaz --scene air --model AtLoc --gpus 0 --data_dir $TEMP/data --weights /home/$USER/cs433-atloc4topo/AtLoc-master/logs/comballaz_air_AtLoc_False/models/epoch_000.pth.tar --final_weights /home/$USER/cs433-atloc4topo/AtLoc-master/logs/comballaz_air_AtLoc_False/models/epoch_085.pth.tar --logdir /home/$USER/cs433-atloc4topo/AtLoc-master/logs
wait
echo END OF $SLURM_JOB_ID AT `date`
