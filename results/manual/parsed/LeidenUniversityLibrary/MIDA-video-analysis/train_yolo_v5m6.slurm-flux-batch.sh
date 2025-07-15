#!/bin/bash
#FLUX: --job-name=t_m4_yolov5
#FLUX: --queue=gpu-long
#FLUX: -t=108000
#FLUX: --priority=16

export CWD='$(pwd)'
export RUNDIR='$SCRATCH/yolov5'
export DATAYAML='$CWD/symbols2.yaml'
export PROJECTDIR='$SCRATCH/training'
export PROJECTNAME='yolo_model_4'
export DATASETS='$SCRATCH/datasets'

module load torchvision/0.8.2-fosscuda-2020b-PyTorch-1.7.1
source $HOME/venvs/yolo_env/bin/activate
echo "[$SHELL] #### Starting GPU YOLOv5 training"
echo "[$SHELL] This is $SLURM_JOB_USER and my job has the ID $SLURM_JOB_ID"
export CWD=$(pwd)
echo "[$SHELL] CWD: "$CWD
echo "[$SHELL] Using GPU: "$CUDA_VISIBLE_DEVICES
echo "[$SHELL] Node scratch: "$SCRATCH
export RUNDIR=$SCRATCH/yolov5
cp -r $HOME/yolov5 $SCRATCH/
echo "[$SHELL] Run directory: "$RUNDIR
export DATAYAML=$CWD/symbols2.yaml
export PROJECTDIR=$SCRATCH/training
export PROJECTNAME=yolo_model_4
export DATASETS=$SCRATCH/datasets
mkdir -p $DATASETS
cp -r $HOME/training_data $DATASETS/
cd $RUNDIR
echo "[$SHELL] Run script"
python train.py --data $DATAYAML --project $PROJECTDIR --name $PROJECTNAME --weights yolov5m6.pt --batch 4 --img 1280 --device $CUDA_VISIBLE_DEVICES --epochs 400
echo "[$SHELL] Script finished"
echo "[$SHELL] Copy files back to cwd"
cd $PROJECTDIR
zip -r $SCRATCH/$PROJECTNAME-$SLURM_JOB_ID.zip ./ 
cp -r $SCRATCH/$PROJECTNAME-$SLURM_JOB_ID.zip $CWD/
echo "[$SHELL] #### Finished GPU training."
