#!/bin/bash
#FLUX: --job-name=stanky-lentil-0036
#FLUX: --priority=16

module load openmpi/gcc/64/1.10.7
rm -f /xfs2/courses/cs/csci4850/princewill.okorie/hpc/mpi_p2p_array
mpic++ /xfs2/courses/cs/csci4850/princewill.okorie/hpc/mpi_p2p_array.cpp -o /xfs2/courses/cs/csci4850/princewill.okorie/hpc/mpi_p2p_array
mpirun /xfs2/courses/cs/csci4850/princewill.okorie/hpc/mpi_p2p_array
exit 0
