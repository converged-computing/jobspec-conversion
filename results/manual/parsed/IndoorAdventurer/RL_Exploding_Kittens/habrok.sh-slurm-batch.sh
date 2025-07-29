#!/bin/bash
#SBATCH --job-name=drl😺
#SBATCH --mail-user=v.tonkes@student.rug.nl
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --time=23:59:59

module purge
module load Python/3.10.8-GCCcore-12.2.0
source $HOME/.envs/ek_drl_env/bin/activate
python $1
deactivate
