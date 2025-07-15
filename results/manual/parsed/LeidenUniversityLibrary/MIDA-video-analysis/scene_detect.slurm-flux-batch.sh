#!/bin/bash
#FLUX: --job-name=scd_all
#FLUX: --queue=gpu-short
#FLUX: -t=7200
#FLUX: --priority=16

export CWD='$(pwd)'
export SD_EPI='$(sed -n ${SLURM_ARRAY_TASK_ID}p $CWD/episodes.txt)'
export DATASETS='$SCRATCH/datasets'
export EPI='ep${SLURM_ARRAY_TASK_ID}'
export VIDEO='$DATASETS/${EPI}.mp4'
export FRAMES_FOLDER='$DATASETS/frames'
export OVIDEO='$(basename "${SD_EPI}")'
export FFREPORT=''

module load rclone
module load FFmpeg
echo "[$SHELL] #### Starting scene detection"
echo "[$SHELL] This job has the ID $SLURM_ARRAY_JOB_ID and task ID $SLURM_ARRAY_TASK_ID"
export CWD=$(pwd)
echo "[$SHELL] CWD: "$CWD
echo "[$SHELL] Using GPU: "$CUDA_VISIBLE_DEVICES
echo "[$SHELL] Node scratch: "$SCRATCH
export SD_EPI=$(sed -n ${SLURM_ARRAY_TASK_ID}p $CWD/episodes.txt)
echo "[$SHELL] File to download from SURFdrive: "$SD_EPI
export DATASETS=$SCRATCH/datasets
mkdir -p $DATASETS
export EPI=ep${SLURM_ARRAY_TASK_ID}
export VIDEO=$DATASETS/${EPI}.mp4
export FRAMES_FOLDER=$DATASETS/frames
echo "[$SHELL] Downloading video file..."
rclone copy "SD:${SD_EPI}" $DATASETS/
ls -lh $DATASETS
export OVIDEO=$(basename "${SD_EPI}")
mv "$DATASETS/$OVIDEO" $VIDEO
echo "[$SHELL] Done downloading video file!"
ls -lh $VIDEO
echo "[$SHELL] Analysing scene changes in ${VIDEO}..."
SCD_DIR=$SCRATCH/"scene-detection/"
mkdir -p "${SCD_DIR}"
OUTPUT_TXT="${SCD_DIR}/${EPI}_ffprobe-flat.txt"
SCD_THRESHOLD=4.5
export FFREPORT="file=${SCD_DIR}/${EPI}_ffprobe-report.log"
CMD="ffprobe -v error -f lavfi -i movie=${VIDEO},scdet=threshold=${SCD_THRESHOLD},blackframe=amount=99:threshold=24,signalstats -show_entries frame=pkt_pts_time,width,height:frame_tags -print_format flat"
${CMD} | sed -E -f ${HOME}/cleanup.txt > ${OUTPUT_TXT}
echo "[$SHELL] Zip scene detection results"
cd $SCD_DIR
zip -r $SCRATCH/${EPI}_${SLURM_ARRAY_JOB_ID}_scd.zip ./
echo "[$SHELL] Copy scene detection results to SURFdrive"
rclone copy $SCRATCH/${EPI}_${SLURM_ARRAY_JOB_ID}_scd.zip SD:ProjectM/arrayjob_frames --timeout 20m --use-cookies
export FFREPORT=""
echo "[$SHELL] Extracting frames from ${VIDEO}..."
LENGTH=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 ${VIDEO})
number_of_frames=$(ffprobe -v error -show_entries stream=nb_frames -select_streams v -of default=noprint_wrappers=1:nokey=1 ${VIDEO})
echo "Total number of frames: ${number_of_frames}"
REDFACTOR=10
folders=$(( (${number_of_frames}/${REDFACTOR}) / 1000))
echo "Folders to create: 0 through "${folders}
iterations=$((${LENGTH%.*} / 400))
echo "Iterations to run: 0 through "$iterations
if [[ ${folders} -ne ${iterations} ]]; then
    echo "Something is wrong in the calculations, exiting"
    exit 1
fi
for START in $(seq 0 $iterations); do
    ST=$((${START} * 400))
    mkdir -p ${FRAMES_FOLDER}/${START}
    echo "Starting extraction at $ST seconds"
    ffmpeg -hide_banner -v error -ss ${ST}.0 -t 400.0 -i ${VIDEO} -vsync passthrough -copyts -lavfi select="not(mod(n\,${REDFACTOR}))" -frame_pts true -qscale:v 1 -qmin 1 -qmax 1 ${FRAMES_FOLDER}/${START}/f-%06d.jpg
done
cd ${FRAMES_FOLDER}
echo "[$SHELL] Tar extracted frames"
tar -cf $SCRATCH/${EPI}_0f.tar ./
echo "[$SHELL] Copy extracted frames to SURFdrive"
rclone copy $SCRATCH/${EPI}_0f.tar SD:ProjectM/extracted_frames --timeout 50m --use-cookies
echo "[$SHELL] #### Finished task!"
