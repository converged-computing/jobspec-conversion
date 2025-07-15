#!/bin/bash
#FLUX: --job-name=JOB_NAME
#FLUX: --queue=gpu_gce
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/work1/cms_mlsim/'
export HOME='/work1/cms_mlsim/CaloDiffusion/ '

set -x
module load singularity
export SINGULARITY_CACHEDIR=/work1/cms_mlsim/
export HOME=/work1/cms_mlsim/CaloDiffusion/ 
torchexec() {
singularity exec --no-home -p --nv --bind `pwd` --bind /cvmfs --bind /cvmfs/unpacked.cern.ch --bind /work1/cms_mlsim/ --bind /wclustre/cms_mlsim/ /cvmfs/unpacked.cern.ch/registry.hub.docker.com/fnallpc/fnallpc-docker:pytorch-1.9.0-cuda11.1-cudnn8-runtime-singularity "$@"
}
cd /work1/cms_mlsim/CaloDiffusion/scripts
export HOME=/work1/cms_mlsim/CaloDiffusion/ 
torchexec bash -c "export HOME=/work1/cms_mlsim/CaloDiffusion/; python3 train_diffu.py --model Diffu --config CONFIG --data_folder /wclustre/cms_mlsim/denoise/CaloChallenge/ --load"
exit
