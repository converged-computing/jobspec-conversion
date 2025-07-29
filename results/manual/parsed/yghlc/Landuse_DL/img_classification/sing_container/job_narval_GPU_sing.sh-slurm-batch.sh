#!/bin/bash
#SBATCH --job-name=testGPU
#SBATCH --account=def-tlantz
#SBATCH --output=%j.out
#SBATCH --mail-user=lingcaohuang@uvic.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=01:00:00

module purge
module load StdEnv/2020 apptainer/1.1.8
echo "== This is the scripting step! =="
./runIN_sing.sh
echo "== End of Job =="
