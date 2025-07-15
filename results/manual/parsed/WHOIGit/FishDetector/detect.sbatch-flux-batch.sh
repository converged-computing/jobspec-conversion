#!/bin/bash
#FLUX: --job-name=FishDetector
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

set -eu
echo "Job ID: $SLURM_JOB_ID, JobName: $SLURM_JOB_NAME"
echo "Command: $0 $@"
hostname; pwd; date
trap date EXIT
[ -n "${CUDA_VISIBLE_DEVICES+x}" ] && HAS_GPU=1 || HAS_GPU=0
module purge
module load default-environment slurm/17.11.12
module load gcc/6.5.0 python3/3.6.5
module load cuda10.1/{toolkit,blas,fft}
if [ ! -d ./cudnn ]; then
    echo "[*] Missing cuDNN directory, loading cuDNN module"
    module load cuda10.1/cudnn/8.0.2
fi
BASEDIR="$(pwd)"
[ ! -d .venv ] && virtualenv .venv
set +u; . .venv/bin/activate; set -u
pip install -r requirements.txt
VIDEOFILE="$1"
NETDIR="$(cd "$2"; pwd)"
NET="${3:-best}"
VIDEONAME="$(basename "$VIDEOFILE" | rev | cut -d . -f 2- | rev)"
NETWORKNAME="network_$(basename "$NETDIR")_$NET"
OUTDIR=detections/"$NETWORKNAME"/"$VIDEONAME"
if [ -d "$OUTDIR" ]; then
    echo "Deleting existing directory $OUTDIR"
    rm -Rf "$OUTDIR"
    find detections/byjob -xtype l -delete || true
fi
mkdir -p "$OUTDIR"
ln -s "$NETDIR" "$OUTDIR"/network
ln -s "$BASEDIR"/logs/detect_"$SLURM_JOB_ID".log "$OUTDIR"/detect.log
mkdir -p detections/byjob || true
ln -s ../../"$OUTDIR" detections/byjob/"$(date +'%Y-%m-%d')"_"$SLURM_JOB_ID"
python process_video.py \
    -v "$VIDEOFILE" \
    --progress \
    --ramdisk \
    --num-cores 1 \
    --nn-config "$OUTDIR"/network/yolo-obj.cfg \
    --nn-weights "$OUTDIR"/network/yolo-obj_"$NET".weights \
    --nn-threshold 0.5 \
    --nn-nms 0.4 \
    --save-detection-data "$OUTDIR" \
    $(cat "$OUTDIR"/network/data/settings.txt)
