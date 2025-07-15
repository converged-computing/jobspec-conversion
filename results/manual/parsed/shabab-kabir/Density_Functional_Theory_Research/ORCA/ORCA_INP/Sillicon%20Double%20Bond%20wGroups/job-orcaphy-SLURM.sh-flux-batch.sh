#!/bin/bash
#FLUX: --job-name=jobname
#FLUX: --exclusive
#FLUX: -t=108000
#FLUX: --priority=16

module load ORCA/5.0.2-gompi-2021b
module load OpenMPI/4.1.1-GCC-9.3.0-UCX-1.10.0-libfabric-1.12.1-PMIx-3.2.3
/opt/oscer/software/ORCA/5.0.2-gompi-2021b/bin/orca 4Si4Phy.inp > 4Si4Phy.out
