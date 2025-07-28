#!/bin/bash
#FLUX: --job-name=TweetAI
#FLUX: -n=4
#FLUX: --queue=gpu05,gpu
#FLUX: -t=432000
#FLUX: --urgency=16

export PATH='$HOME/software/bin:$PATH;'

module load utilities/multi
module load readline/7.0
module load gcc/10.2.0
module load cuda/11.5.0
module load python/anaconda/4.6/miniconda/3.7
show_help() {
	echo -e "Usage:" >&2;
	echo -e "    [POSTFIX='<string>' ]CONFIG='path/to/config.toml' sbatch slurm.job" >&2;
	echo -e "" >&2;
	echo -e "....where:" >&2;
	echo -e "    CONFIG  The filepath to the config file containing the parameters for this run" >&2;
	echo -e "    POSTFIX Optional. A suffix to apply to the run code name." >&2;
	echo -e "" >&2;
	echo -e "The code used to identify the run is taken automatically from the filename of the config file." >&2;
	exit;
}
if [[ -z "${CONFIG}" ]]; then
	echo -e "Error: No CONFIG environment variable specified.\n" >&2;
	show_help;
fi
if [[ ! -e "${CONFIG}" ]]; then
	echo -e "Error: The config file path '${CONFIG}' doesn't exist.";
	exit 1;
fi
CODE="$(basename "${CONFIG}")";
CODE="${CODE%.*}";
if [[ ! -z "${POSTFIX}" ]]; then
	echo -e ">>> Applying postfix of ${POSTFIX}" >&2;
	CODE="${CODE}_${POSTFIX}";
fi
echo -e ">>> Config file: ${CONFIG}" >&2;
echo -e ">>> Code: ${CODE}" >&2;
echo -e ">>> Additional args: ${ARGS}";
dir_output="output/$(date -u --rfc-3339=date)_${CODE}";
export PATH=$HOME/software/bin:$PATH;
echo ">>> Installing requirements";
conda run -n py38 pip install -r requirements.txt;
echo ">>> Training model";
/usr/bin/env time -v conda run -n py38 src/text_classifier.py --only-gpu --config "${CONFIG}" --output "${dir_output}" ${ARGS};
echo ">>> exited with code $?";
