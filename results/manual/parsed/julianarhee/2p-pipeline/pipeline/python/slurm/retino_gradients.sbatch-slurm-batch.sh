#!/bin/bash
#SBATCH --job-name=gradients
#SBATCH --output=retinograd_%A_%a.out
#SBATCH --error=retinograd_%A_%a.err
#SBATCH --mail-user=rhee@g.harvard.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8192
#SBATCH --time=00:00:20
#SBATCH --partition=cox

module load centos6/0.0.1-fasrc01
module load matlab/R2015b-fasrc01
module load Anaconda/5.0.1-fasrc01
source activate /n/coxfs01/2p-pipeline/envs/pipeline
ANIMALID="$1"
SESSION="$2"
FOV="$3"
EXP="$4"
TRACEID="$5"
FILTER="$6"
echo "ANIMALID: ${ANIMALID}"
echo "SESSION: ${SESSION}"
python /n/coxfs01/2p-pipeline/repos/2p-pipeline/pipeline/python/classifications/gradient_estimation.py -i $ANIMALID -S $SESSION -A $FOV -R $EXP -t $TRACEID -c magenta --plot-examples -p $FILTER --thr 0.002
