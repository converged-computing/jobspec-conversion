#!/bin/bash
#FLUX: --job-name=pusheena-lettuce-1873
#FLUX: --urgency=16

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
