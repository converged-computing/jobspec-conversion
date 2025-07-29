#!/bin/bash
#SBATCH --job-name=roc
#SBATCH --output=roc_%A_%a.out
#SBATCH --error=roc_%A_%a.err
#SBATCH --mail-user=rhee@g.harvard.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32764
#SBATCH --time=00:04:00

module load centos6/0.0.1-fasrc01
module load matlab/R2015b-fasrc01
module load Anaconda/5.0.1-fasrc01
source activate /n/coxfs01/2p-pipeline/envs/pipeline
echo ${1}
echo ${2}
echo ${3}
echo ${4}
python /n/coxfs01/2p-pipeline/repos/2p-pipeline/pipeline/python/classifications/bootstrap_roc.py --slurm -i ${1} -S ${2} -A ${3} -E ${4} -t ${5} -n 8 --plot 
