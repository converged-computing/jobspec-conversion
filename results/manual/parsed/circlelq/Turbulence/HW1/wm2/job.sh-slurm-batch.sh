#!/bin/bash
#SBATCH --job-name=lqy
#SBATCH --output=slurm.%j.out
#SBATCH --mail-user=circle20101561@163.com
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=compute
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=20

module load matlab/R2021a
matlab -nodesktop -nosplash -nodisplay -r main
echo 'finished!'
