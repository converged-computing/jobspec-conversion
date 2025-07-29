#!/bin/bash
#SBATCH --job-name=ABAW6_preprocess
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --mail-user=gnana-praveen.rajasekhar@crim.ca
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15G
#SBATCH --time=15-00:00:00
#SBATCH --constraint=ntasks-per-node=1

export PATH='/misc/scratch11/anaconda3/bin:$PATH'

export PATH="/misc/scratch11/anaconda3/bin:$PATH"
source activate pre
scripts_dir=`pwd`
MatlabFE=`pwd`
mdl=senet18e17
lf=ocsoftmax
atype=LA
python3 main.py
wait
echo "DONE"
