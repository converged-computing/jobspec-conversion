#!/bin/bash
#SBATCH --job-name=gmrt_cnn
#SBATCH --account=pawsey0245
#SBATCH --mail-user=kevin.vinsen@icrar.org
#SBATCH --mail-type=TIME_LIMIT_90
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=05:00:00

module load use.own
module load broadwell gcc/5.4.0 cuda python magma cffi
source /group/pawsey0245/kvinsen/pytorch/bin/activate
cd /group/pawsey0245/kvinsen/rfi_ml/src
srun -n 1 python -m cProfile -o train_gmrt_cnn.prof train_gmrt_cnn.py --use-gpu --save gmrt_cnn.model.saved --epochs 4 --batch-size 100000
