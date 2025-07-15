#!/bin/bash
#FLUX: --job-name=crusty-butter-0422
#FLUX: --queue=high-mem
#FLUX: -t=86400
#FLUX: --priority=16

export N='$(printf %03d $SLURM_ARRAY_TASK_ID)'

start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "Script started at: $start_time"
conda activate pytorch-orchid
export N=$(printf %03d $SLURM_ARRAY_TASK_ID)
python /gws/nopw/j04/nceo_generic/nceo_ucl/TLS/tools/TLS2trees/tls2trees/instance.py \
-t "$scratch_dir/fsct/${N}.downsample.segmented.ply" --tindex "$project_dir/tile_index.dat" \
-o "$scratch_dir/clouds/" --n-tiles 7 --slice-thickness .5 --find-stems-boundary 2.5 3. \
--pandarallel --verbose --add-leaves --add-leaves-voxel-length .5 \
--graph-maximum-cumulative-gap 3 --save-diameter-class --ignore-missing-tiles
end_time=$(date "+%Y-%m-%d %H:%M:%S")
echo -e "Script finished at: $end_time"
start_timestamp=$(date -d "$start_time" +%s)
end_timestamp=$(date -d "$end_time" +%s)
duration=$((end_timestamp - start_timestamp))
hours=$((duration / 3600))
minutes=$(( (duration % 3600) / 60 ))
seconds=$((duration % 60))
echo -e "Total duration: $hours:$minutes:$seconds (hh:mm:ss)"
