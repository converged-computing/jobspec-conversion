#!/bin/bash
#FLUX: --job-name=joyous-toaster-3702
#FLUX: --urgency=16

eval $(spack load --sh miniconda3)
source activate active-learning
if [[ $# -eq 1 ]] ; then
    dirname=$1
    args="--checkpoint "$dirname
elif [[ $# -eq 0 ]] ; then
    dirname=ModelFitting/SVM/
    mkdir -p "${dirname}"
    args=$dirname
else
    echo "Usage: $(basename $0) [checkpoint_dir]"
    exit 1
fi
python3 src/svm_multiclass_cross_validation.py $args
