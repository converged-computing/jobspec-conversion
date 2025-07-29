#!/bin/bash
#SBATCH --job-name=cw-test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module purge
module load intel/18 python/3.6.4 
source /home/lv71235/mmatak/adversarial_framework/venv/bin/activate
python /home/lv71235/mmatak/adversarial_framework/main.py cw
