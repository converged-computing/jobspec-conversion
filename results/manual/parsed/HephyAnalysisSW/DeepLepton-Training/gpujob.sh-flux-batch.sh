#!/bin/bash
#FLUX: --job-name=gpujob
#FLUX: -c=10
#FLUX: --queue=g
#FLUX: -t=72000
#FLUX: --priority=16

singularity run --nv /cvmfs/unpacked.cern.ch/registry.hub.docker.com/cernml4reco/deepjetcore3:latest /users/maximilian.moser/DeepLeptonStuff/DeepLepton-Training/convert.sh
echo "done"
