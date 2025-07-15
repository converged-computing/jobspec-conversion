#!/bin/bash
#FLUX: --job-name=openmm_cg_cuda
#FLUX: --queue=gpu
#FLUX: --priority=16

whoami
id -a
docker run --rm --runtime=nvidia -v $(dirname `pwd`):$(dirname `pwd`) -w `pwd` bmset/gromacs_openmm:latest bash ../run_martinize.sh
docker run --rm --runtime=nvidia -v $(dirname `pwd`):$(dirname `pwd`) -w `pwd` bmset/gromacs_openmm:latest python ../generate_gro_file.py
docker run --rm --runtime=nvidia -v $(dirname `pwd`):$(dirname `pwd`) -w `pwd` bmset/gromacs_openmm:latest bash ../create_simulation.sh 2 20
docker run --rm --runtime=nvidia -v $(dirname `pwd`):$(dirname `pwd`) -w `pwd` bmset/gromacs_openmm:latest python ../run_CG_simulation.py
