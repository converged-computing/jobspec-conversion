#!/bin/bash
#FLUX: --job-name=wobbly-sundae-4841
#FLUX: --exclusive
#FLUX: --queue=dev
#FLUX: -t=86400
#FLUX: --priority=16

spack install \
  --no-check-signature \
  --no-checksum \
  --use-cache \
  py-tensorflow +cuda \
  py-torch +cuda \
  py-scikit-learn \
  py-scikit-image \
  py-scipy \
  py-scikit-optimize \
  py-scientificpython \
  py-ipykernel
