#!/bin/bash
#FLUX: --job-name=expressive-toaster-7961
#FLUX: --exclusive
#FLUX: --priority=16

module purge
current_timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}
ts=$(current_timestamp)
cd "$WORK"/deepfigures-results || exit
if [ -z ${SLURM_ARRAY_TASK_ID+x} ]; then
  echo "SLURM_ARRAY_TASK_ID is not set. Stopping the job."
  exit
fi
i=$SLURM_ARRAY_TASK_ID
NUM_CPUS=$(lscpu | grep "CPU(s)" | head -1 | awk -F' ' '{print $2}')
NUM_CPUS_TIMES_2=$((NUM_CPUS * 2))
NUM_CPUS_TIMES_3=$((NUM_CPUS * 3))
echo "Number of CPUs : $NUM_CPUS"
echo "Number of CPUs times 2 : $NUM_CPUS_TIMES_2"
echo "Number of CPUs times 3 : $NUM_CPUS_TIMES_3"
SCRATCH_DIR=/scratch-local/"$SLURM_JOBID"/tmpfs
if [ "$SYSNAME" = "dragonstooth" ]; then
  SCRATCH_DIR=/scratch-local/"$SLURM_JOBID"/tmpfs
fi
ARXIV_DATA_TEMP="$SCRATCH_DIR"/arxiv_data_temp
DOWNLOAD_CACHE="$SCRATCH_DIR"/download_cache
ARXIV_DATA_OUTPUT="$SCRATCH_DIR"/arxiv_data_output
ZIP_SAVE_DIR="$SCRATCH_DIR"/"$SYSNAME"_"$SLURM_JOBID"_"$i"_"$ts"
ZIP_DEST_DIR=/work/"$SYSNAME"/sampanna/deepfigures-results/pregenerated_training_data/$SLURM_ARRAY_JOB_ID
WORK_DIR_PREFIX="$SYSNAME"_"$SLURM_JOBID"_"$i"_"$ts"
mkdir -p "$ARXIV_DATA_TEMP"
mkdir -p "$DOWNLOAD_CACHE"
mkdir -p "$ARXIV_DATA_OUTPUT"
mkdir -p "$ZIP_SAVE_DIR"
mkdir -p "$ZIP_DEST_DIR"
echo "Copying tar files to $SCRATCH_DIR..."
cat ~/deepfigures-open/hpc/files_random_40/files_"$i".json | grep tar | awk -F '/' '{print $3"_"$4"_"$5}' | awk -F '"' '{print "/work/cascades/sampanna/deepfigures-results/download_cache/"$1}' | xargs cp -t "$DOWNLOAD_CACHE"
/home/sampanna/.conda/envs/deepfigures/bin/python /home/sampanna/deepfigures-open/deepfigures/data_generation/training_data_generator.py \
  --file_list_json /home/sampanna/deepfigures-open/hpc/files_random_40/files_"$i".json \
  --images_per_zip=500 \
  --zip_save_dir="$ZIP_SAVE_DIR" \
  --zip_dest_dir="$ZIP_DEST_DIR" \
  --n_cpu=$NUM_CPUS_TIMES_2 \
  --work_dir_prefix "$WORK_DIR_PREFIX" \
  --arxiv_tmp_dir "$ARXIV_DATA_TEMP" \
  --arxiv_cache_dir "$DOWNLOAD_CACHE" \
  --arxiv_data_output_dir "$ARXIV_DATA_OUTPUT" \
  --delete_tar_after_extracting True \
  --augment_typewriter_font True \
  --augment_line_spacing_1_5 True
echo "Job ended. Job ID: $SLURM_JOBID . Array ID: $i"
exit
