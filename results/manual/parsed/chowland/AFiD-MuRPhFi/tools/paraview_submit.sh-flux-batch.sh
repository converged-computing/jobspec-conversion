#!/bin/bash
#FLUX --job-name=creamy-banana-7625
#FLUX --exclusive
#FLUX --queue=rome
#FLUX -t=3600
#FLUX --urgency=16

module load 2022
module load ParaView-server-osmesa/5.10.1-foss-2022a-mpi
srun pvserver --force-offscreen-rendering
