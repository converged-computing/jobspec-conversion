#!/bin/bash
#FLUX: --job-name=fuzzy-dog-6268
#FLUX: -c=32
#FLUX: --urgency=16

set -euo pipefail
module load 2021
module load MATLAB/2021a-upd3
mcc -m ./src/STEMMUS_SCOPE_exe.m -a ./src -d ./exe -o STEMMUS_SCOPE -R nodisplay -R singleCompThread
