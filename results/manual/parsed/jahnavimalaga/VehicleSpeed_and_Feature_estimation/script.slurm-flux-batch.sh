#!/bin/bash
#FLUX: --job-name=delicious-mango-5827
#FLUX: --urgency=16

cd Complete_Pipeline
path_dir="test/" #"test/archive/new_videos/" #
for file in "$path_dir"/* #.{mov,mp4}
do
    file_name=$(basename "$file")
    # Remove the .py extension
    file_name_without_extension="${file_name%.*}" #"${file_name%.mp4}"
    PYTHONWARNINGS="ignore::FutureWarning" python3 main.py --name "$file_name_without_extension" --conf-thres 0.25 --source "$file" --device 0 --hide-conf --save-vid --save-txt --strong-sort-weights weights/osnet_x0_25_msmt17.pt --yolo-weights weights/yolov8n-seg.pt --classes 1 2 3 5 7
    #python3 main.py --name "$file_name_without_extension" --conf-thres 0.25 --source "$file" --device 0 --hide-conf --save-txt --strong-sort-weights weights/osnet_x0_25_msmt17.pt --yolo-weights weights/yolov8n-seg.pt --classes 1 2 3 5 7
    #sleep 60
done
echo "Your job has completed $SLURM_JOB_ID"
