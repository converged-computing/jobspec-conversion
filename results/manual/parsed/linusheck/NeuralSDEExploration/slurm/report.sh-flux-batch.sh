#!/bin/bash
#FLUX: --job-name=analyze
#FLUX: -t=14400
#FLUX: --urgency=16

export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'

echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "Running on nodes: $SLURM_NODELIST"
echo "------------------------------------------------------------"
export I_MPI_PMI_LIBRARY=/p/system/slurm/lib/libpmi.so
module purge
module load julia
module add texlive
/home/linushe/neuralsdeexploration/slurm/latestfile.sh | xargs julia --project=/home/linushe/neuralsdeexploration /home/linushe/neuralsdeexploration/scripts/generate_report.jl
