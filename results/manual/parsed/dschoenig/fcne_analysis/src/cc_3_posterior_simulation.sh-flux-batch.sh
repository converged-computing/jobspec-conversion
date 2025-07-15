#!/bin/bash
#FLUX: --job-name=doopy-general-9442
#FLUX: -c=4
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load StdEnv/2023 gcc/12.3 gdal/3.7.2 geos/3.12.0 python/3.11.5 udunits/2.2.28 arrow/15.0.1 thrift/0.19.0 r/4.3.1
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
Rscript 3_posterior_simulation.R AMZ $SLURM_CPUS_PER_TASK
Rscript 3_posterior_simulation.R CAM $SLURM_CPUS_PER_TASK
