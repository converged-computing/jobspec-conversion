#!/bin/bash
#SBATCH --job-name=cpah
#SBATCH --output=/home/users/m/mikriukov/projects/cpah/out_gpu_short.log
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:tesla:1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=1-00:00:00

echo "Loading venv..."
source /home/users/m/mikriukov/venvs/DADH/bin/activate
echo "Loading cuda..."
module load nvidia/cuda/10.1
echo "Running 128..."
python3 main.py train --flag $1 --proc short --bit 128
python3 main.py test --flag $1 --proc short --bit 128
echo "Running 64..."
python3 main.py train --flag $1 --proc short --bit 64
python3 main.py test --flag $1 --proc short --bit 64
echo "Running 32..."
python3 main.py train --flag $1 --proc short --bit 32
python3 main.py test --flag $1 --proc short --bit 32
echo "Running 16..."
python3 main.py train --flag $1 --proc short --bit 16
python3 main.py test --flag $1 --proc short --bit 16
echo "Running 8..."
python3 main.py train --flag $1 --proc short --bit 8
python3 main.py test --flag $1 --proc short --bit 8
