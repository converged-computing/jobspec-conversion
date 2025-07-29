#!/bin/bash
#SBATCH --job-name=ConvLr00001
#SBATCH --account=PSYC0005
#SBATCH --output=gpu4_%A.txt
#SBATCH --error=error%A.err
#SBATCH --mail-user=nspranav1180@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:v100:2
#SBATCH --mem=88g
#SBATCH --time=5-08:00:00
#SBATCH --partition=qTRDGPUH

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/'

source /home/users/pnadigapusuresh1/anaconda3/bin/activate latest
python distributed_conv.py ${SLURM_ARRAY_TASK_ID}
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/
echo $HOSTNAME >&2
module load Framework/Matlab2019b
matlab -batch 'array_example($SLURM_ARRAY_TASK_ID)'
sleep 30s
