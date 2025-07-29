#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=dev_q

echo "Scrpt Start"
echo "Core Number:"
nproc --all
pwd
ls
echo "load Anaconda"
module load Anaconda
conda list -f scikit-learn
python --version
python main.py
echo "Scrpt End"
