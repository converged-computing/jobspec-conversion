#!/bin/bash
#SBATCH --account=project_462000119
#SBATCH --output=logs/install_apex.out
#SBATCH --error=logs/install_apex.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:mi250:1
#SBATCH --time=01:00:00

module --quiet purge
module load cray-python
source venv/bin/activate
cd apex
python setup.py install --cpp_ext --cuda_ext
