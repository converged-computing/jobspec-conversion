#!/bin/bash
#SBATCH --job-name=find-gpu
#SBATCH --account=ec37
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=2G
#SBATCH --time=00:10:00
#SBATCH --partition=accel
#SBATCH --qos=devel

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default
module use -a /fp/projects01/ec30/software/easybuild/modules/all/
module load nlpl-pytorch/1.7.1-foss-2019b-cuda-11.1.1-Python-3.7.4
python -c "import torch; print(torch.cuda.is_available())"
