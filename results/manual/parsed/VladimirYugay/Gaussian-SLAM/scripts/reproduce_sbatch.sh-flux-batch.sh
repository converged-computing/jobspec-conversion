#!/bin/bash
#FLUX: --job-name=adorable-staircase-2121
#FLUX: -c=12
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

dataset="Replica" # set dataset
if [ "$dataset" == "Replica" ]; then
    scenes=("room0" "room1" "room2" "office0" "office1" "office2" "office3" "office4")
    INPUT_PATH="data/Replica-SLAM"
elif [ "$dataset" == "TUM_RGBD" ]; then
    scenes=("rgbd_dataset_freiburg1_desk" "rgbd_dataset_freiburg2_xyz" "rgbd_dataset_freiburg3_long_office_household")
    INPUT_PATH="data/TUM_RGBD-SLAM"
elif [ "$dataset" == "ScanNet" ]; then
    scenes=("scene0000_00" "scene0059_00" "scene0106_00" "scene0169_00" "scene0181_00" "scene0207_00")
    INPUT_PATH="data/scannet/scans"
elif [ "$dataset" == "ScanNetPP" ]; then
    scenes=("b20a261fdf" "8b5caf3398" "fb05e13ad1" "2e74812d00" "281bc17764")
    INPUT_PATH="data/scannetpp/data"
else
    echo "Dataset not recognized!"
    exit 1
fi
OUTPUT_PATH="output"
CONFIG_PATH="configs/${dataset}"
EXPERIMENT_NAME="reproduce"
SCENE_NAME=${scenes[$SLURM_ARRAY_TASK_ID]}
source <path-to-conda.sh> # please change accordingly
conda activate gslam
echo "Job for dataset: $dataset, scene: $SCENE_NAME"
echo "Starting on: $(date)"
echo "Running on node: $(hostname)"
python run_slam.py "${CONFIG_PATH}/${SCENE_NAME}.yaml" \
                   --input_path "${INPUT_PATH}/${SCENE_NAME}" \
                   --output_path "${OUTPUT_PATH}/${dataset}/${EXPERIMENT_NAME}/${SCENE_NAME}" \
                   --group_name "${EXPERIMENT_NAME}" \
echo "Job for scene $SCENE_NAME completed."
echo "Started at: $START_TIME"
echo "Finished at: $(date)"
