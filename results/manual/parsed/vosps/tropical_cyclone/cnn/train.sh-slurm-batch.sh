#!/bin/bash
#SBATCH --job-name=cgan
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32gb
#SBATCH --time=2-23:00:00
#SBATCH --constraint=ntasks-per-node=1

source ~/.bashrc
cd $SLURM_SUBMIT_DIR
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Slurm job ID is $SLURM_JOBID
echo This jobs runs on the following machines:
echo $SLURM_JOB_NODELIST
module load lang/python/anaconda/3.7-2019.03
source activate /user/work/al18709/.conda/envs/jungle
nvidia-smi
nvcc -V
echo jungle environment activated
echo running cgan
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt"
srun python make_predictions.py
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt"
