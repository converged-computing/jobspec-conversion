#!/bin/bash
#SBATCH --job-name=analyze
#SBATCH --account=tipes
#SBATCH --output=/home/linushe/outputs/%x.%A_%4a.out
#SBATCH --mail-user=linus.heck@rwth-aachen.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --time=04:00:00

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
