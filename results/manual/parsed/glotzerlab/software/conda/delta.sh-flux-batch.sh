#!/bin/bash
#FLUX: --job-name=glotzerlab-software build
#FLUX: -c=16
#FLUX: --queue=cpu
#FLUX: -t=28800
#FLUX: --urgency=16

export OUTPUT_FOLDER='/projects/bbgw/software/conda'

export OUTPUT_FOLDER=/projects/bbgw/software/conda
unset CMAKE_PREFIX_PATH
module reset
module load gcc/11.4.0 openmpi/4.1.6 cuda/12.3.0
./build.sh "$@" \
    --skip-existing \
    --variants "{'cluster': ['delta'], 'device': ['gpu'], 'gpu_platform': ['CUDA']}" \
    --output-folder $OUTPUT_FOLDER
chmod g-w $OUTPUT_FOLDER -R
chmod g+rX $OUTPUT_FOLDER -R
