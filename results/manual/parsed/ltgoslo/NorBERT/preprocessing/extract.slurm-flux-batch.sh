#!/bin/bash
#FLUX: --job-name=preprocessing
#FLUX: -n=4
#FLUX: -t=86340
#FLUX: --urgency=16

umask 0007
module purge   # Recommended for reproducibility
module load Python/3.7.4-GCCcore-8.3.0
./extract_text_from_xml.sh
