#!/bin/bash
#FLUX: --job-name=arid-train-6572
#FLUX: -t=900
#FLUX: --urgency=16

export DATA_DIR='$(mktemp -d -p $TMPDIR)'

module load nvidia-cntk
export DATA_DIR=$(mktemp -d -p $TMPDIR)
echo 'Data dir is '$DATA_DIR
cp /scratch/scip/data/cntk/MNIST/*.txt $DATA_DIR
singularity_wrapper exec python cntk_mnist_ex4.py
rm -r $DATA_DIR
