#!/bin/bash
#SBATCH --account=def-someuser
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000M
#SBATCH --time=00:03:00

module load python
module list
source /path/to/your/env/bin/activate
python cifar10_resnet.py --max_epochs 50 --n_jobs 1 --batch_size 2000
