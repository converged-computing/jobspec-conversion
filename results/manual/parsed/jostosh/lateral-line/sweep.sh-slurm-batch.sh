#!/bin/bash
#SBATCH --job-name=LLSWEEP
#SBATCH --output=LLSWEEP-%j.log
#SBATCH --mail-user=jos.vandewolfshaar@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=4000
#SBATCH --time=06:00:00

module load tensorflow
source $HOME/envs/ll/bin/activate
cd $HOME/lateral-line
python3 ./generate_data.py $*
srun python3 ./sweep.py $*
