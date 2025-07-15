#!/bin/bash
#FLUX: --job-name=FishDetector
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

set -eu
echo "Job ID: $SLURM_JOB_ID, JobName: $SLURM_JOB_NAME"
echo "Command: $0 $@"
hostname; pwd; date
trap date EXIT
[ -n "${CUDA_VISIBLE_DEVICES+x}" ]
module purge
module load default-environment slurm/17.11.12
module load gcc/6.5.0 python3/3.6.5
module load cuda10.1/{toolkit,blas,fft}
if [ ! -d ./cudnn ]; then
    echo "[*] Missing cuDNN directory, loading cuDNN module"
    module load cuda10.1/cudnn/8.0.2
fi
[ ! -d .venv ] && virtualenv .venv
set +u; . .venv/bin/activate; set -u
pip install -r requirements.txt
VIDEOFILE="$1"
shift
PROCESS_ARGS="$@"
VIDEONAME="$(basename "$VIDEOFILE" | rev | cut -d . -f 2- | rev)"
SCRIPT_IDENTIFIER="$(git log -n 1 --pretty=format:%H -- process_video.py)"
if git diff --quiet process_video.py; then 
    SCRIPT_IDENTIFIER="$SCRIPT_IDENTIFIER"_dirty
fi
FINGERPRINT="$(echo "$SCRIPT_IDENTIFIER;$PROCESS_ARGS" | openssl md5 | cut -d ' ' -f 2)"
echo "Using fingerprint $FINGERPRINT"
if [ ! -d data/"$FINGERPRINT" ]; then
    mkdir -p data/"$FINGERPRINT"
fi
echo "$SCRIPT_IDENTIFIER" > data/"$FINGERPRINT"/version.txt
echo "$PROCESS_ARGS" > data/"$FINGERPRINT"/settings.txt
OUTDIR=data/"$FINGERPRINT"/"$VIDEONAME"
mkdir -p "$OUTDIR"
mkdir -p data/byjob || true
ln -s ../../"$OUTDIR" data/byjob/"$(date +'%Y-%m-%d')"_"$SLURM_JOB_ID"
for LIST in test.txt train.txt valid.txt; do
    if [ -f "data/${FINGERPRINT}/${LIST}" ]; then
        echo "Frame list ${LIST} detected, using it"
        PROCESS_ARGS="$PROCESS_ARGS --frame-list data/${FINGERPRINT}/${LIST}"
    fi
done
python process_video.py \
    -v "$VIDEOFILE" \
    --progress \
    --ramdisk \
    --num-cores 2 \
    --save-preprocessed "$OUTDIR" \
    $PROCESS_ARGS
