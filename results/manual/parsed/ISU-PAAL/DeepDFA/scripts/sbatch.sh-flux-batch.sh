#!/bin/bash
#FLUX: --job-name=sbatch
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

source activate.sh
module load gcc/10.2.0-zuvaafu cuda/11.3.1-z4twu5r
nvidia-smi
which python
python -V
which pip
pip -V
log_filename="slurmlog_$(echo $@ | sed -e 's@ @-@g' -e 's@/@-@g').log"
echo $log_filename
echo "command: $@"
$@ 2>&1 | tee $log_filename
