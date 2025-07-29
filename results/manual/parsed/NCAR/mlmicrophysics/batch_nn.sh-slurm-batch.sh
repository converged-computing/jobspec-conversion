#!/bin/bash
#SBATCH --job-name=micro_nn
#SBATCH --account=NAML0001
#SBATCH --output=sd_nn_half.o
#SBATCH --error=sd_nn_half.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=128G
#SBATCH --time=23:00:00

export PATH='/glade/u/home/ggantos/ncar_20200417/bin:$PATH'

module load gnu/8.3.0 openmpi/3.1.4 python/3.7.5 cuda/10.1
ncar_pylib ncar_20200417
export PATH="/glade/u/home/ggantos/ncar_20200417/bin:$PATH"
pip install /glade/work/ggantos/mlmicrophysics/.
python scripts/train_mp_neural_nets.py config/cesm_sd_full_train_nn.yml
