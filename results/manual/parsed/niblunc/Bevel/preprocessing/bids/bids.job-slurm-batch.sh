#!/bin/bash
#SBATCH --job-name=BEVEL_BIDS
#SBATCH --output=/projects/niblab/bids_projects/Experiments/Bevel/error_files/bids_error_%a_out.txt
#SBATCH --error=/projects/niblab/bids_projects/Experiments/Bevel/error_files/bids_error_%a_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=80000
#SBATCH --time=02:00:00

if [ ${SLURM_ARRAY_TASK_ID} -lt 10 ]; then
    sub="sub-00${SLURM_ARRAY_TASK_ID}"
else
    sub="sub-0${SLURM_ARRAY_TASK_ID}"
fi
singularity exec -B /:/base_dir /projects/niblab/bids_projects/Singularity_Containers/heudiconv_05_2019.simg \
heudiconv -b -d /base_dir/projects/niblab/bids_projects/Experiments/Bevel/DICOMS/sub-{subject}/*dcm -s sub \
-f /base_dir/projects/niblab/bids_projects/Experiments/Bevel/BIDS/code/bevel_heuristic.py \
-c dcm2niix -o /base_dir/projects/niblab/bids_projects/Experiments/Bevel/BIDS
