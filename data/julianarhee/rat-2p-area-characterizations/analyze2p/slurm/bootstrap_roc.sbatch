#!/bin/bash
# bootstrap_roc.sbatch
#
#SBATCH -J roc # A single job name for the array
#SBATCH -p shared # run on cox gpu to use correct env 
#SBATCH -n 4 # one core
#SBATCH -N 1 # on one node
#SBATCH -t 0-02:00 # Running time of 3 hours
#SBATCH --mem 16384 #70656 # Memory request of 70 GB (set to 98304 if exceed lim)
#SBATCH -o roc_%A_%a.out # Standard output
#SBATCH -e roc_%A_%a.err # Standard error
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=rhee@g.harvard.edu


# load modules
module load centos6/0.0.1-fasrc01
#module load matlab/R2015b-fasrc01
module load Anaconda/5.0.1-fasrc01

# activate 2p-pipeline environment:
#source activate /n/coxfs01/2p-pipeline/envs/pipeline
source activate /n/coxfs01/2p-pipeline/envs/rat2p #pipeline

# grab filename from array exported from 'parent' shell:
#FILENAME="$1"
#echo "File: ${FILENAME}"

echo ${1}
echo ${2}
echo ${3}

# run processing on raw data
python /n/coxfs01/2p-pipeline/repos/rat-2p-area-characterizations/analyze2p/bootstrap_roc.py -k ${1} -E ${2} -t ${3} -n 4 --plot 
