#!/bin/bash
#FLUX: --job-name=eccentric-nunchucks-3425
#FLUX: --exclusive
#FLUX: --priority=16

echo "Starting job..."
source anaconda3/bin/activate
conda activate dataset_tools
for i in $(seq 0 10)
do
    args=(
        SRC_DIR
        DST_DIR
        --num-partitions 10
        --partition $i
        --height 144
        --width 256
        # --wait-for-list-file
    )
    # [[ $i != 0 ]] && args+=(--wait-for-list-file)
    srun -N 1 -n 1 --exclusive python dataset_tools/make_dataset_from_videos.py "${args[@]}" &
done
wait
