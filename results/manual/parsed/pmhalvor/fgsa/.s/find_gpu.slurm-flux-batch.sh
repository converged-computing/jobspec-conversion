#!/bin/bash
#FLUX: --job-name=find-gpu
#FLUX: --queue=accel
#FLUX: -t=600
#FLUX: --urgency=16

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default
module use -a /fp/projects01/ec30/software/easybuild/modules/all/
module load nlpl-pytorch/1.7.1-foss-2019b-cuda-11.1.1-Python-3.7.4
python -c "import torch; print(torch.cuda.is_available())"
