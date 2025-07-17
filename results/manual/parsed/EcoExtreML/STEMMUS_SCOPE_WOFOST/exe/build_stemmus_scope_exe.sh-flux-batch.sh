#!/bin/bash
#FLUX: --job-name=stemmus_scope
#FLUX: -c=32
#FLUX: --queue=thin
#FLUX: -t=300
#FLUX: --urgency=16

set -euo pipefail
module load 2021
module load MATLAB/2021a-upd3
mcc -m ./src/STEMMUS_SCOPE_exe.m -a ./src -d ./exe -o STEMMUS_SCOPE -R nodisplay -R singleCompThread
