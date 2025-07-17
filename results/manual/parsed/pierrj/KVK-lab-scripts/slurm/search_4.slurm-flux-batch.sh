#!/bin/bash
#FLUX: --job-name=search_4
#FLUX: -N=20
#FLUX: -c=10
#FLUX: --queue=savio
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load gcc/7.4.0
module load openmpi
module load cmake
cd /global/scratch/users/pierrj/PAV_SV/PAV/raxml_ng_test
mpirun /global/scratch/users/pierrj/raxml_ng_savio1/bin/raxml-ng-mpi --msa savio1_T1.raxml.rba --prefix search_4 --threads 10 --extra thread-pin --seed 44444
