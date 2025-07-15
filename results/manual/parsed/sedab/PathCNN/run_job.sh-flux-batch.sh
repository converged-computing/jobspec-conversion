#!/bin/bash
#FLUX: --job-name=train_PCNN
#FLUX: -n=8
#FLUX: --queue=gpu8_long
#FLUX: --priority=16

echo "Starting at `date`"
echo "Job name: $SLURM_JOB_NAME JobID: $SLURM_JOB_ID"
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running on $SLURM_NPROCS processors."
module purge
module load python/gpu/3.6.5 
exp_name="pancan_21c_tr"
nparam="--cuda  --augment --dropout=0.1 --nonlinearity=leaky --init=xavier  --root_dir=/gpfs/scratch/bilals01/AllDs600/AllDs600TilesSorted/ --num_class=21 --tile_dict_path=/gpfs/scratch/bilals01/AllDs600/AllDs600_FileMappingDict.p" 
nexp="/gpfs/scratch/bilals01/test-repo/experiments/${exp_name}"
output="/gpfs/scratch/bilals01/test-repo/logs/${exp_name}.log" 
python3 -u /gpfs/scratch/bilals01/test-repo/PathCNN/train.py $nparam --experiment $nexp > $output
