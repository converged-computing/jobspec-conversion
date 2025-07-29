#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --time=02:00:00
#SBATCH --constraint=haswell

export PATH='/global/common/software/m2865/bella-proj/g0-bin:$PATH'

module load valgrind
set -x
DIR=/global/cscratch1/sd/mme/daligner_j16235709 #ecoli 30x (sample)
cd $DIR
cp $0 ./ # copy this script to the run directory (documentation)
export PATH=/global/common/software/m2865/bella-proj/g0-bin:$PATH
NEW=valgrind_align.sh
cp align.sh $NEW
sed -i -e 's/daligner/valgrind --tool=massif --pages-as-heap=yes daligner/g' $NEW && cat $NEW
set +x
sh $NEW 
