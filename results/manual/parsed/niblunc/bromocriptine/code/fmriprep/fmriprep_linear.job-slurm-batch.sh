#!/bin/bash
#SBATCH --job-name=BRO_BEVEL
#SBATCH --output=/projects/niblab/bids_projects/Experiments/BRO/scripts/fmriprep/error_files/lin_fprep_%a_out.txt
#SBATCH --error=/projects/niblab/bids_projects/Experiments/BRO/scripts/fmriprep/error_files/lin_fprep_%a_err.txt
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=80000
#SBATCH --time=1-00:00:00

if [ ${SLURM_ARRAY_TASK_ID} -lt 10 ]; then
    sub="sub-00${SLURM_ARRAY_TASK_ID}"
else
    sub="sub-0${SLURM_ARRAY_TASK_ID}"
fi
singularity exec -B /projects/niblab/bids_projects:/base_dir -B /projects/niblab/bids_projects/mytemplateflowdir:/opt/templateflow /projects/niblab/bids_projects/Singularity_Containers/fmriprep_v2_2019.simg \
fmriprep /base_dir/Experiments/BRO/BIDS /base_dir/Experiments/BRO/fmriprep \
    participant  \
    --participant-label $sub  \
    --skip_bids_validation \
    --fs-license-file /base_dir/freesurfer/license.txt \
    --fs-no-reconall \
    --omp-nthreads 16 --n_cpus 16 \
    --ignore slicetiming  \
    --bold2t1w-dof 12 \
    --output-spaces MNI152Lin \
     -w /base_dir/Experiments/BRO/fmriprep \
     --resource-monitor --write-graph --stop-on-first-crash 
