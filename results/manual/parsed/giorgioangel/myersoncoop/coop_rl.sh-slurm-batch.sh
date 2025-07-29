#!/bin/bash
#SBATCH --job-name=fc_rl
#SBATCH --mail-user=giorgio.angelotti@isae.fr
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=1-00:00:00

export LD_LIBRARY_PATH='/home/dcas/g.angelotti/.conda/envs/coop/lib:$LD_LIBRARY_PATH'

module load python/3.8
source activate coop
export LD_LIBRARY_PATH=/home/dcas/g.angelotti/.conda/envs/coop/lib:$LD_LIBRARY_PATH
python -W ignore main.py --exact 15 --full 1 --sim_num 72 --pol_a random --pol_b rl
