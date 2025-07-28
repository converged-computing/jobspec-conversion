#!/bin/bash
#FLUX: --job-name=inspyrenet
#FLUX: --queue=A6000
#FLUX: -t=259200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR" echo "CUDA_HOME=$CUDA_HOME"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "CUDA_VERSION=$CUDA_VERSION"
srun -l /bin/hostname
srun -l /bin/pwd
srun -l /bin/date
module purge  # Remove all modules.
module load postech  
echo "Start"
echo "source $HOME/anaconda3/etc/profile.d/conda.sh"
source $HOME/anaconda3/etc/profile.d/conda.sh
echo "conda activate inspyrenet" 
conda activate inspyrenet
cd Projects/InSPyReNet
torchrun --standalone --nproc_per_node=8 run/Train.py --config $1 --verbose --debug
date
echo "conda deactivate"
conda deactivate
squeue --job $SLURM_JOBID
