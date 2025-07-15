#!/bin/bash
#FLUX: --job-name=conspicuous-bicycle-5143
#FLUX: -t=3600
#FLUX: --urgency=16

set -e
source env-build-fenics.sh
./build-petsc.sh
./build-python-modules.sh
./build-fenics.sh
mkdir -p ${PREFIX}/bin
cp env-build-fenics.sh ${PREFIX}/bin/env-build-fenics.sh
cp env-fenics.sh ${PREFIX}/bin/env-fenics.sh
