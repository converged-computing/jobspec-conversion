#!/bin/bash
#SBATCH --job-name=compile_Enzo
#SBATCH --mail-user=g.kerex@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=1
#SBATCH --time=00:30:00

pwd; hostname; date
module add cuda
moudle add cudnn
./make-rusty.sh
date
