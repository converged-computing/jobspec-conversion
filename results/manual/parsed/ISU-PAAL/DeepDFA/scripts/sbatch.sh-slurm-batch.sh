#!/bin/bash
#SBATCH --job-name=sbatch
#SBATCH --output=sbatch_%j.info
#SBATCH --error=sbatch_%j.info
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=3-00:00:00

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
