#!/bin/bash
#FLUX: --job-name=spicy-taco-3853
#FLUX: --urgency=16

source /etc/profile.d/modules.sh                            # Use this to add the module command to the path of compute nodes.
module load Python3/3.9.6
source $(conda info --base)/etc/profile.d/conda.sh          # Use if conda is already on your path but you still need to run "conda init <shell_name>"       
conda activate base
hostname
python3.9 --version
echo $CONDA_DEFAULT_ENV                                     # $CONDA_DEFAULT_ENV shows the activated env
