#!/bin/bash
#SBATCH --job-name=Jul6_Cont_SS_HKNN_job
#SBATCH --output=Jul6_Cont_SS_HKNN_job_%j.log
#SBATCH --mail-user=clare.morris@alleninstitute.org
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500gb
#SBATCH --time=10-00:00:00

mkdir $TMPDIR/tmp
singularity exec --bind=/scratch/fast/$SLURM_JOBID/tmp:/tmp docker://alleninst/mapping_on_hpc Rscript R_scripts/Cont_SS_HKNN.R > logfiles/Jul6_Cont_SS_HKNN_logfile
