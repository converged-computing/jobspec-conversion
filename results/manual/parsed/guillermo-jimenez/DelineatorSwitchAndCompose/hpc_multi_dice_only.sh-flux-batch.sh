#!/bin/bash
#FLUX: --job-name=muffled-despacito-5504
#FLUX: -c=8
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK;'

list_all_models=(UNet5LevelsDiceOnly WNet5LevelsDiceOnly WNet5LevelsSelfAttentionDiceOnly WNet5LevelsSelfAttentionConvDiceOnly WNet5LevelsConvDiceOnly UNet5LevelsConvDiceOnly
UNet6LevelsDiceOnly WNet6LevelsDiceOnly WNet6LevelsSelfAttentionDiceOnly WNet6LevelsSelfAttentionConvDiceOnly WNet6LevelsConvDiceOnly UNet6LevelsConvDiceOnly
UNet7LevelsDiceOnly WNet7LevelsDiceOnly WNet7LevelsSelfAttentionDiceOnly WNet7LevelsSelfAttentionConvDiceOnly WNet7LevelsConvDiceOnly UNet7LevelsConvDiceOnly)
if [ $SLURM_ARRAY_TASK_ID -gt ${#list_all_models[@]} ];
then 
    exit 1
fi
model=${list_all_models[$SLURM_ARRAY_TASK_ID]}
module load Python/3.6.4-foss-2017a;
module load PyTorch/1.6.0-foss-2017a-Python-3.6.4-CUDA-10.1.105;
module load OpenBLAS/0.2.19-foss-2017a-LAPACK-3.7.0;
module load OpenMPI/2.0.2-GCC-6.3.0-2.27;
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK;
source ~/VirtEnv/DeepLearning3/bin/activate;
cd ~/GitHub/DelineatorSwitchAndCompose;
python3 train_multi.py --config_file ./configurations/${model}.json --input_files ./pickle/ --model_name ${model}_$(date '+%Y%m%d%H%M%S') --hpc 1;
