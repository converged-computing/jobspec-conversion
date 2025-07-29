#!/bin/bash
#SBATCH --job-name=CompletePipleline
#SBATCH --output=CompletePipleline.out
#SBATCH --error=CompletePipleline.err
#SBATCH --mail-user=jahnavimalagavalli@utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

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
