#!/bin/bash
#SBATCH --job-name=render_data
#SBATCH --output=hostname_%j.out
#SBATCH --error=hostname_%j.err
#SBATCH --mail-user=gp14958@my.bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --mem=15000
#SBATCH --time=00:06:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-50

export PATH='$PATH:/mnt/storage/scratch/gp14958/blender-2.79-linux-glibc219-x86_64/'
export SCENE_DIR='/mnt/storage/scratch/gp14958/scene_data_final'
export PREFIX='10000'

module unload Python/2.7.11-foss-2016a
module load libGLU/9.0.0-foss-2016a-Mesa-11.2.1
module load libs/cudnn/8.0-cuda-8.0
export PATH=$PATH:/mnt/storage/scratch/gp14958/blender-2.79-linux-glibc219-x86_64/
export SCENE_DIR=/mnt/storage/scratch/gp14958/scene_data_final
export PREFIX=10000
srun python runner.py --arr=$SLURM_ARRAY_TASK_ID
