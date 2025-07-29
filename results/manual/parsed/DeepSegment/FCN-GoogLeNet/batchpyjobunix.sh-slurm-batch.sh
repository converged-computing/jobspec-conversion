#!/bin/bash
#SBATCH --job-name=mypyjob
#SBATCH --account=2017-85
#SBATCH --output=output_file.o
#SBATCH --error=error_file.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:K80:2
#SBATCH --time=5-00:00:00

module add cudnn/5.1-cuda-8.0
module load anaconda/py35/4.2.0
source activate tensorflow
module load i-compilers/17.0.1
module load intelmpi/17.0.1
mpirun -np 1 python ./inception_FCN.py > my_output_file
source deactivate
