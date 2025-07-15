#!/bin/bash
#FLUX: --job-name=bricky-gato-7400
#FLUX: --queue=gpu
#FLUX: --priority=16

IMG=/home/software/singularity/tf-2.14.0.simg
cd ~/particleflow
EXPDIR=experiments/cms-gen_20231213_152224_108072.gpu1.local
WEIGHTS=experiments/cms-gen_20231213_152224_108072.gpu1.local/weights/weights-10-3.068836.hdf5
singularity exec -B /scratch/persistent --nv \
    --env PYTHONPATH=hep_tfds \
    --env TFDS_DATA_DIR=/scratch/persistent/joosep/tensorflow_datasets \
    $IMG python3.10 mlpf/pipeline.py evaluate \
    --train-dir $EXPDIR --weights $WEIGHTS
singularity exec -B /scratch/persistent --nv \
    --env PYTHONPATH=hep_tfds \
    --env TFDS_DATA_DIR=/scratch/persistent/joosep/tensorflow_datasets \
    $IMG python3.10 mlpf/pipeline.py plots \
    --train-dir $EXPDIR
