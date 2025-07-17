#!/bin/bash
#FLUX: --job-name=sad
#FLUX: -N=16
#FLUX: -c=4
#FLUX: --queue=physical
#FLUX: -t=259200
#FLUX: --urgency=16

export BASENJIDIR='/data/gpfs/projects/punim0614/andy/basenji21/basenji'
export PATH='$BASENJIDIR/bin:$PATH'
export PYTHONPATH='$BASENJIDIR/bin:$PYTHONPATH'

module load Python/3.7.1-GCC-6.2.0
module load Tensorflow/1.15.0-GCC-6.2.0-Python-3.7.1-GPU
export BASENJIDIR=/data/gpfs/projects/punim0614/andy/basenji21/basenji
export PATH=$BASENJIDIR/bin:$PATH
export PYTHONPATH=$BASENJIDIR/bin:$PYTHONPATH
source ${HOME}/basenji/bin/activate
python ../bin/basenji_sad.py --cpu -f data/hg19.ml.fa -o output/rfx6_sad_all --rc --shift "1,0,-1" -t data/lcl_wigs.txt models/params.txt models/lcl/model_human.tf data/dsQTL.eval.flipped.vcf
