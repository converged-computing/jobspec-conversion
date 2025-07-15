#!/bin/bash
#FLUX: --job-name=yolo_train
#FLUX: --queue=allgroups
#FLUX: -t=82800
#FLUX: --priority=16

model_name=medium_lv_mhp_merged_b16
dataset_path=LV-MHP-v1-YOLO-merge
cd $WORKING_DIR/Code/YOLOv8_mhp
mkdir $model_name
cd $model_name
echo $PWD
echo "Sourcing the .bashrc file"
source /home/girottopie/.bashrc
echo "Sourced!"
echo "Donwloading yolo env..."
gdrivedownload 1Y5F4GiSOkCblF3zkXWj50OXsTKPzh478 /ext/yolo_env.sif
echo "YOLO env donwloaded!"
srun singularity exec --nv /ext/yolo_env.sif yolo segment train data=../$dataset_path/dataset.yaml model=yolov8m-seg.pt epochs=100 imgsz=640 batch=16 device=0,1
mv ../*.txt ./
