#!/bin/bash
#FLUX: --job-name=fat-lizard-3804
#FLUX: --exclusive
#FLUX: --urgency=16

module load 2022
module load ParaView-server-osmesa/5.10.1-foss-2022a-mpi
srun pvserver --force-offscreen-rendering
