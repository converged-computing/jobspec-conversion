#!/bin/bash
#FLUX: --job-name=creamy-onion-9964
#FLUX: --priority=16

export OMP_NUM_THREADS='$omp_thread          # OpenMP, Numpy'
export MKL_NUM_THREADS='$omp_thread          # Intel MKL'
export NUMEXPR_NUM_THREADS='$omp_thread      # Python3 Multiproc'
export OMP_STACKSIZE='1G'
export KMP_AFFINITY='scatter '

module load cuda11.0/toolkit/11.0.3
module load cudnn8.1-cuda11.2/8.1.1.33
module load ex3-modules
module load slurm/20.02.7
module load python-3.7.4
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_thread          # OpenMP, Numpy
export MKL_NUM_THREADS=$omp_thread          # Intel MKL
export NUMEXPR_NUM_THREADS=$omp_thread      # Python3 Multiproc
export OMP_STACKSIZE=1G
export KMP_AFFINITY=scatter 
echo "Phosc"
python3 main.py --name ResNet34PretrainDrop1Dense --mode train --model Resnet34_temporalpooling --epochs 100 --train_csv /global/D1/homes/aniket/data/IAM_Data1/iamSplit_Aspect_1024#10_05_2011#/train.csv --train_folder /global/D1/homes/aniket/data/IAM_Data1/iamSplit_Aspect_1024#10_05_2011#/train --valid_csv /global/D1/homes/aniket/data/IAM_Data1/iamSplit_Aspect_1024#10_05_2011#/val1.csv --valid_folder /global/D1/homes/aniket/data/IAM_Data1/iamSplit_Aspect_1024#10_05_2011#/val
exit 0
