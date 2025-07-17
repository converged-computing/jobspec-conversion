#!/bin/bash
#FLUX: --job-name=TwImgCfM
#FLUX: -n=4
#FLUX: --queue=gpu05,gpu
#FLUX: -t=43200
#FLUX: --urgency=16

export PATH='$HOME/software/bin:$PATH;'

module load utilities/multi
module load readline/7.0
module load gcc/10.2.0
module load cuda/11.5.0
module load python/anaconda/4.6/miniconda/3.7
INPUT="${INPUT:-$HOME/data/twitter/tweets-all-labelled-c2-transformer-e21-val_acc=0.794/all.jsonl}";
CHECKPOINT="${CHECKPOINT}"; # Example: output/20220110-resnet/checkpoints/checkpoint_e22_val_acc0.606.hdf5
CONFIG="${CONFIG:-configs/imageclassifier.toml}"
if [[ -z "${CHECKPOINT}" ]]; then
	echo "Error: No checkpoint specified in the CHECKPOINT environment variable.";
	exit 1;
fi
if [[ ! -r "${CHECKPOINT}" ]]; then
	echo "Error: That checkpoint file doesn't exist.";
	exit 2;
fi
if [[ ! -r "${INPUT}" ]]; then
	echo "Error: That input tweets file doesn't exist.";
	exit 3;
fi
checkpoint_filename="$(basename "${CHECKPOINT}")";
model_dirname="$(basename "$(dirname "$(dirname "${CHECKPOINT}")")")"
filename_output="${model_dirname}_${checkpoint_filename%.*}${POSTFIX}.png";
dir_output="output";
if [[ ! -d "${dir_output}" ]]; then
	mkdir -p "${dir_output}";
fi
target_output="${dir_output}/${filename_output}";
export PATH=$HOME/software/bin:$PATH;
echo ">>> Installing requirements";
conda run -n py38 pip install -r requirements.txt;
echo ">>> Training model";
/usr/bin/env time -v conda run -n py38 src/confusion_matrix_image.py --config "${CONFIG}" --input-tweets "${INPUT}" --output "${target_output}" --only-gpu --model "${CHECKPOINT}"
echo ">>> exited with code $?";
