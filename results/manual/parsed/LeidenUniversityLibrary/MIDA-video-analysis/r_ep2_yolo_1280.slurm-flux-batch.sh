#!/bin/bash
#FLUX: --job-name=m3_ep2
#FLUX: --queue=gpu-short
#FLUX: -t=5400
#FLUX: --priority=16

export CWD='$(pwd)'
export RUNDIR='$SCRATCH/yolov5'
export PROJECTDIR='$SCRATCH/detection'
export MODEL='$SCRATCH/yolo_1280.pt'
export DATASETS='$SCRATCH/datasets'

module load torchvision/0.8.2-fosscuda-2020b-PyTorch-1.7.1
source $HOME/venvs/yolo_env/bin/activate
echo "[$SHELL] #### Starting GPU YOLOv5 detection"
echo "[$SHELL] This is $SLURM_JOB_USER and my job has the ID $SLURM_JOB_ID"
export CWD=$(pwd)
echo "[$SHELL] CWD: "$CWD
echo "[$SHELL] Using GPU: "$CUDA_VISIBLE_DEVICES
echo "[$SHELL] Node scratch: "$SCRATCH
export RUNDIR=$SCRATCH/yolov5
cp -r $HOME/yolov5 $SCRATCH/
echo "[$SHELL] Run directory: "$RUNDIR
export PROJECTDIR=$SCRATCH/detection
export MODEL=$SCRATCH/yolo_1280.pt
cp $HOME/models/yolo_model_3/weights/best.pt $MODEL
export DATASETS=$SCRATCH/datasets
mkdir -p $DATASETS
cp -r $HOME/ep2_0f.tar $DATASETS/
cd $DATASETS
tar -xf ep2_0f.tar
cd $RUNDIR
echo "[$SHELL] Run script"
for F in $(find $DATASETS -mindepth 1 -maxdepth 1 -type d)
do
echo "Starting on ${F#${DATASETS}/}"
python detect.py --source $F/'**/*.jpg' --project $PROJECTDIR --name "ep2_${F#${DATASETS}/}" --img 1280 --weights $MODEL --device $CUDA_VISIBLE_DEVICES --save-txt --save-conf
done
echo "[$SHELL] Script finished"
echo "[$SHELL] Remove dataset of images"
rm -rf $DATASETS
echo "[$SHELL] Zip and copy files back to cwd"
cd $PROJECTDIR
zip -r $SCRATCH/ep2_$SLURM_JOB_ID.zip ./ 
cp -r $SCRATCH/ep2_$SLURM_JOB_ID.zip $CWD/
echo "[$SHELL] #### Finished detection."
