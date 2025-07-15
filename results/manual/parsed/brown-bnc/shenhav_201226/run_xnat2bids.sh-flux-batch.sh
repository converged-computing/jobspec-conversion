#!/bin/bash
#FLUX: --job-name=red-spoon-4516
#FLUX: --priority=16

set -u
set -a
[ -f .env ] && . .env
set +a
version=v1.0.5
simg=/gpfs/data/bnc/simgs/brownbnc/xnat-tools-${version}.sif
data_dir=/gpfs/data/bnc
output_dir=${data_dir}/shared/bids-export/${USER}
mkdir -m 775 ${output_dir} || echo "Output directory already exists"
bidsmap_dir=/users/$USER/src/bnc/shenhav_201226/preprocessing/xnat2bids
bidsmap_file=shenhav_201226.json
tmp_dir=/gpfs/scratch/$USER/xnat2bids
mkdir -m 775 ${tmp_dir} || echo "Temp directory already exists"
declare -A sessions=([200]="XNAT7_E00063" \
                     [148]="XNAT_E00005" )
declare -A skip_map=([200]="-s 6"\
                     [148]="-s 6")
XNAT_SESSION=${sessions[${SLURM_ARRAY_TASK_ID}]}
SKIP_STRING=${skip_map[${SLURM_ARRAY_TASK_ID}]}
echo "Processing session:"
echo ${XNAT_SESSION}
echo "Series to skip:"
echo ${SKIP_STRING}
singularity exec --no-home -B ${output_dir} -B ${bidsmap_dir}:/bidsmaps:ro ${simg} \
    xnat2bids ${XNAT_SESSION} ${output_dir} \
    -u ${XNAT_USER} \
    -p "${XNAT_PASSWORD}" \
    --overwrite \
    ${SKIP_STRING} 
