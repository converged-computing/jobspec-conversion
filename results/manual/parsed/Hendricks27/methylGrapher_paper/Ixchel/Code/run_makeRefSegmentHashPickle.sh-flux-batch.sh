#!/bin/bash
#FLUX: --job-name=scruptious-gato-5585
#FLUX: --urgency=16

echo "Loading software..."
eval $( spack load --sh python@3 )
eval $( spack load --sh py-numpy/i7mcgz4 )
eval $( spack load --sh py-jsonpickle@1.4.1 )
eval $( spack load --sh py-dill@0.3.4 )
INPUTSEGMENTSFILE=$1
OUTOUTPICKLE=$2
echo "Start conversion..."
python3 /scratch/hllab/Juan/General_Code/makeRefSegmentHashPickle.py $INPUTSEGMENTSFILE $OUTOUTPICKLE
echo "Complete!"
