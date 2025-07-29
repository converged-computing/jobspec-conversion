#!/bin/bash
#SBATCH --output=log/svm_multiclass_cross_validation.out
#SBATCH --error=log/svm_multiclass_cross_validation.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=650G

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
