#!/bin/bash
#FLUX: --job-name=glotzerlab-software build
#FLUX: -c=36
#FLUX: --queue=standard
#FLUX: -t=28800
#FLUX: --urgency=16

export OUTPUT_FOLDER='/nfs/turbo/glotzer/software/conda'
export TMPDIR='/tmpssd'

export OUTPUT_FOLDER=/nfs/turbo/glotzer/software/conda
unset CMAKE_PREFIX_PATH
module reset
module load gcc/10.3.0 openmpi/4.1.6 cuda/12.3.0
export TMPDIR=/tmpssd
./build.sh "$@" \
    --skip-existing \
    --variants "{'cluster': ['greatlakes'], 'device': ['gpu'], 'gpu_platform': ['CUDA']}" \
    --output-folder $OUTPUT_FOLDER
chmod g-w $OUTPUT_FOLDER -R
