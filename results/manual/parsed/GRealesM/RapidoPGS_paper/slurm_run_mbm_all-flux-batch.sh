#!/bin/bash
#FLUX: --job-name=mbmall
#FLUX: -n=15
#FLUX: --queue=skylake-himem
#FLUX: -t=115200
#FLUX: --urgency=16

export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'

. /etc/profile.d/modules.sh # Leave this line (enables the module command)
module purge                # Removes all modules still loaded
module load rhel7/default-peta4            # REQUIRED - loads the basic environment
module load r-4.0.2-gcc-5.4.0-xyx46xb
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
JOBID=$SLURM_JOB_ID
echo -e "JobID: $JOBID"
G=$SLURM_ARRAY_TASK_ID ### this is the array variable, you can use it the way you want. In this example I use it to select the gene based on the line number in a file
Rscript /home/gr440/rds/rds-cew54-basis/05-PGS/v3/code/Benchmarking_all_20210317.R $G
