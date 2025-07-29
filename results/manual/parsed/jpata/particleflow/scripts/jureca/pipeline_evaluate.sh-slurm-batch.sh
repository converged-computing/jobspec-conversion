#!/bin/bash
#SBATCH --job-name=pipeeval
#SBATCH --account=raise-ctp2
#SBATCH --output=logs_slurm/log_%x_%j.out
#SBATCH --error=logs_slurm/log_%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=01:59:59

export CUDA_VISIBLE_DEVICES='0'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module purge
module load GCC GCCcore/.11.2.0 CMake NCCL CUDA cuDNN OpenMPI
export CUDA_VISIBLE_DEVICES=0
jutil env activate -p raise-ctp2
nvidia-smi
source /p/project/raise-ctp2/cern/miniconda3/bin/activate tf2
echo "Python used:"
which python3
python3 --version
echo 'Starting evaluation.'
CUDA_VISIBLE_DEVICES=0 python3 mlpf/pipeline.py compute_validation_loss -t $1
echo 'Evaluation done.'
