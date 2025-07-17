#!/bin/bash
#FLUX: --job-name=ornery-cattywampus-7796
#FLUX: --urgency=16

export SINGULARITYENV_PYTHONNOUSERSITE='true'
export SINGULARITYENV_OMP_NUM_THREADS='1'

set -e
set -x
model=$(jq -r .model config.json)
if [ $model != "bwn" ]; then
    save_var="--save-variance"
fi
rm -rf *.nii.gz #clean output from prevsious run
export SINGULARITYENV_PYTHONNOUSERSITE=true
export SINGULARITYENV_OMP_NUM_THREADS=1
time singularity run --nv -e docker://neuronets/kwyk:version-0.4-gpu \
    -m $model \
    -n $(jq -r .samples config.json) \
    $save_var \
    --save-entropy $(jq -r .t1 config.json) \
    output
mkdir -p parc
mv output_means_orig.nii.gz parc/parc.nii.gz
cp key.txt parc
mkdir -p output 
mv output_entropy_orig.nii.gz output/entropy.nii.gz
mkdir -p parc_fs
mv output_means.nii.gz parc_fs/parc.nii.gz
cp key.txt parc_fs
mkdir -p output_fs
mv output_entropy.nii.gz output_fs/entropy.nii.gz
if [ $model != "bwn" ]; then
    mv output_variance.nii.gz output_fs/variance.nii.gz
    mv output_variance_orig.nii.gz output/variance.nii.gz
fi
