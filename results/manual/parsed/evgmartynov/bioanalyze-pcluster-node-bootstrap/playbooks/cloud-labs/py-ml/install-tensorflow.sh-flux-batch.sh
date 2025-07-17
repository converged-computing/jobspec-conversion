#!/bin/bash
#FLUX: --job-name=expressive-snack-2817
#FLUX: --exclusive
#FLUX: --queue=dev
#FLUX: -t=86400
#FLUX: --urgency=16

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
