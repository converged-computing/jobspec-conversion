#!/bin/bash
#FLUX: --job-name=DelSwitch
#FLUX: -c=8
#FLUX: --queue=high
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK;'

module load Python/3.6.4-foss-2017a;
module load PyTorch/1.6.0-foss-2017a-Python-3.6.4-CUDA-10.1.105;
module load OpenBLAS/0.2.19-foss-2017a-LAPACK-3.7.0;
module load OpenMPI/2.0.2-GCC-6.3.0-2.27;
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK;
source ~/VirtEnv/DeepLearning3/bin/activate;
cd ~/GitHub/DelineatorSwitchAndCompose;
python3 train_multi.py --config_file ./configurations/HPC/${SLURM_ARRAY_TASK_ID}.json --input_files ./pickle/ --model_name TESTF1Loss_${SLURM_ARRAY_TASK_ID} --hpc 1;
