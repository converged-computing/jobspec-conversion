#!/bin/bash
#FLUX --job-name=milky-caramel-7533
#FLUX -t=300
#FLUX --urgency=16

srun --mpi=pmix_v3 ./adam.out 500000
