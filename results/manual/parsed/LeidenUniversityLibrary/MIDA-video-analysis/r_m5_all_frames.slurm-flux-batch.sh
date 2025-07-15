#!/bin/bash
#FLUX: --job-name=r_m5_all_f
#FLUX: --queue=gpu-short
#FLUX: -t=7200
#FLUX: --priority=16

export CWD='$(pwd)'
export RUNDIR='$SCRATCH/yolov5'
export PROJECTDIR='$SCRATCH/detection'
export MODEL='$SCRATCH/yolo_1280.pt'
export DATASETS='$SCRATCH/datasets'
export EPI='ep${SLURM_ARRAY_TASK_ID}'
export FRAMES_FOLDER='$DATASETS/frames'
export FRAMES_TAR='${EPI}_0f.tar'
export RECOGNITION_ZIP='$SCRATCH/${EPI}_${SLURM_ARRAY_JOB_ID}_recognitions.zip'

module load torchvision/0.8.2-fosscuda-2020b-PyTorch-1.7.1
module load rclone
source $HOME/venvs/yolo_env/bin/activate
echo "[$SHELL] #### Starting GPU YOLOv5 detection with model 5"
echo "[$SHELL] This job has the ID $SLURM_ARRAY_JOB_ID and task ID $SLURM_ARRAY_TASK_ID"
export CWD=$(pwd)
echo "[$SHELL] CWD: "$CWD
echo "[$SHELL] Using GPU: "$CUDA_VISIBLE_DEVICES
echo "[$SHELL] Node scratch: "$SCRATCH
export RUNDIR=$SCRATCH/yolov5
cp -r $HOME/yolov5 $SCRATCH/
echo "[$SHELL] Run directory: "$RUNDIR
export PROJECTDIR=$SCRATCH/detection
echo "[$SHELL] Copying the YOLO model to scratch..."
export MODEL=$SCRATCH/yolo_1280.pt
cp $HOME/models/yolo_model_5/weights/best.pt $MODEL
export DATASETS=$SCRATCH/datasets
mkdir -p $DATASETS
export EPI=ep${SLURM_ARRAY_TASK_ID}
export FRAMES_FOLDER=$DATASETS/frames
mkdir -p ${FRAMES_FOLDER}
export FRAMES_TAR=${EPI}_0f.tar
echo "[$SHELL] Copy extracted frames from SURFdrive"
rclone copy SD:ProjectM/extracted_frames/${FRAMES_TAR} $SCRATCH --timeout 50m --use-cookies
cd ${FRAMES_FOLDER}
echo "[$SHELL] Untar extracted frames"
tar -xf $SCRATCH/${FRAMES_TAR}
ls -lh
cd $RUNDIR
echo "[$SHELL] Run YOLO detection"
for F in $(find $FRAMES_FOLDER -mindepth 1 -maxdepth 1 -type d)
do
ITERATION=${F#${FRAMES_FOLDER}/}
echo "Starting on ${ITERATION}"
python detect.py --source $F/'**/*.jpg' --project $PROJECTDIR --name "${EPI}_${ITERATION}" --img 1280 --weights $MODEL --device $CUDA_VISIBLE_DEVICES --save-txt --save-conf --save-crop --nosave
done
echo "[$SHELL] YOLO detection finished"
echo "[$SHELL] Zip recognition results"
export RECOGNITION_ZIP=$SCRATCH/${EPI}_${SLURM_ARRAY_JOB_ID}_recognitions.zip
cd $PROJECTDIR/
zip -r ${RECOGNITION_ZIP} ./
echo "[$SHELL] Copy recognition results to SURFdrive"
rclone copy ${RECOGNITION_ZIP} SD:ProjectM/arrayjob_frames --timeout 20m --use-cookies
echo "[$SHELL] #### Finished task!"
