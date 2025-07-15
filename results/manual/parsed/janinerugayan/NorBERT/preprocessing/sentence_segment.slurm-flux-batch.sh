#!/bin/bash
#FLUX: --job-name=segmenting
#FLUX: -n=8
#FLUX: --queue=accel
#FLUX: -t=72000
#FLUX: --priority=16

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module use -a /cluster/projects/nn9851k/software/easybuild/install/modules/all/
module purge
module load NLPL-stanza/1.1.1-gomkl-2019b-Python-3.7.4
echo "Input file: ${1}"
echo "Language: ${2}"
echo "Output file: ${3}"
zcat ${1} | python3 segmenter.py ${2} | gzip > ${3}
