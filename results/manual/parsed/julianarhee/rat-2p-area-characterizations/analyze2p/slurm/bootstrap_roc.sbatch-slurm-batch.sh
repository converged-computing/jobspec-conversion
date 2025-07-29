#!/bin/bash
#SBATCH --job-name=roc
#SBATCH --output=roc_%A_%a.out
#SBATCH --error=roc_%A_%a.err
#SBATCH --mail-user=rhee@g.harvard.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16384
#SBATCH --time=00:02:00

module load centos6/0.0.1-fasrc01
module load Anaconda/5.0.1-fasrc01
source activate /n/coxfs01/2p-pipeline/envs/rat2p #pipeline
echo ${1}
echo ${2}
echo ${3}
python /n/coxfs01/2p-pipeline/repos/rat-2p-area-characterizations/analyze2p/bootstrap_roc.py -k ${1} -E ${2} -t ${3} -n 4 --plot 
