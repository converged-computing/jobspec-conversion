#!/bin/bash
#FLUX: --job-name=irace_mpi_tuning2
#FLUX: -n=21
#FLUX: -t=86399
#FLUX: --urgency=16

module load OpenMPI
module load R
srun /opt/sw/arch/easybuild/2021b/software/R/4.1.2-foss-2021b/lib64/R/library/irace/bin/irace --exec-dir=/home/unamur/fac_info/asion/swarm_aggregation/tuning2 --parallel 19 --mpi 1 --scenario scenario.txt
