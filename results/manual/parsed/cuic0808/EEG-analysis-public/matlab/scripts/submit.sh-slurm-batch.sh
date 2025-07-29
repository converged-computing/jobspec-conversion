#!/bin/bash
#SBATCH --job-name=wavelet
#SBATCH --account=p31274
#SBATCH --output=/home/yyr4332/logs/%A.log
#SBATCH --mail-user=yyu@u.northwestern.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=2

module purge all
module load matlab/r2020b
cd /home/yyr4332/project/matlab/
matlab -nosplash -nodesktop -singleCompThread -r yy_auto_process
