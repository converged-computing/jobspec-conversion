#!/bin/bash
#SBATCH --job-name=inspyrenet
#SBATCH --output=train.%j.out
#SBATCH --mail-user=taehoon1018@postech.ac.kr
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --time=3-00:00:00
#SBATCH --partition=A6000
#SBATCH --constraint=ntasks-per-node=8

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
