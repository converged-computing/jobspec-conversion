#!/bin/bash
#FLUX: --job-name=stinky-bits-5939
#FLUX: --queue=orchid
#FLUX: -t=18000
#FLUX: --urgency=16

export N='$(printf %03d $SLURM_ARRAY_TASK_ID)'

start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "Script started at: $start_time"
conda activate pytorch-orchid
export N=$(printf %03d $SLURM_ARRAY_TASK_ID)
python /gws/nopw/j04/nceo_generic/nceo_ucl/TLS/tools/TLS2trees/tls2trees/semantic.py --point-cloud $scratch_dir/downsample/${N}.downsample.ply --odir $scratch_dir/fsct --verbose --buffer 5 --tile-index $project_dir/tile_index.dat
end_time=$(date "+%Y-%m-%d %H:%M:%S")
echo -e "Script finished at: $end_time"
start_timestamp=$(date -d "$start_time" +%s)
end_timestamp=$(date -d "$end_time" +%s)
duration=$((end_timestamp - start_timestamp))
hours=$((duration / 3600))
minutes=$(( (duration % 3600) / 60 ))
seconds=$((duration % 60))
echo -e "Total duration: $hours:$minutes:$seconds (hh:mm:ss)"
