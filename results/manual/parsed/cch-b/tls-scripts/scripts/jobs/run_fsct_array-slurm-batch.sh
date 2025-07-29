#!/bin/bash
#SBATCH --account=orchid
#SBATCH --output=/work/scratch-pw3/ucfacc2/sbatch_logs/ss/%x_%j_%A_%a.out
#SBATCH --error=/work/scratch-pw3/ucfacc2/sbatch_logs/ss/%x_%j_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=128000
#SBATCH --time=05:00:00
#SBATCH --partition=orchid
#SBATCH --array=000-790

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
