#!/bin/bash
#FLUX: --job-name=tart-eagle-6555
#FLUX: --exclusive
#FLUX: --priority=16

module load 2022
module load ParaView-server-osmesa/5.10.1-foss-2022a-mpi
srun pvserver --force-offscreen-rendering
