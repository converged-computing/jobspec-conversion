#!/bin/bash
#FLUX: --job-name=fmriprep
#FLUX: -c=8
#FLUX: --queue=IB_40C_512G
#FLUX: -t=216000
#FLUX: --priority=16

export SINGULARITYENV_TEMPLATEFLOW_HOME='${TEMPLATEFLOW_HOST_HOME}'

pwd; hostname; date
set -e
module load singularity-3.5.3
fmriprep_ver=21.0.0
DSET_DIR="/home/data/abcd/abcd-hispanic-via"
BIDS_DIR="${DSET_DIR}/dset"
THISJOBVALUE=${SLURM_ARRAY_TASK_ID}
subject=$( sed -n -E "$((${THISJOBVALUE} + 1))s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv )
CODE_DIR="${DSET_DIR}/code"
IMG_DIR="/home/data/cis/singularity-images"
DERIVS_DIR="${BIDS_DIR}/derivatives/fmriprep-${fmriprep_ver}"
SCRATCH_DIR="/scratch/nbc/jpera054/abcd_work/fmriprep-${fmriprep_ver}/$subject"
mkdir -p ${DERIVS_DIR}
mkdir -p ${SCRATCH_DIR}
TEMPLATEFLOW_HOST_HOME="/home/data/cis/templateflow"
FMRIPREP_HOST_CACHE=${HOME}/.cache/fmriprep
mkdir -p ${TEMPLATEFLOW_HOST_HOME}
mkdir -p ${FMRIPREP_HOST_CACHE}
FS_LICENSE="/home/jpera054/Documents/freesurfer"
export SINGULARITYENV_TEMPLATEFLOW_HOME=${TEMPLATEFLOW_HOST_HOME}
SINGULARITY_CMD="singularity run --cleanenv \
      -B ${BIDS_DIR}:/data \
      -B ${DERIVS_DIR}:/out \
      -B ${TEMPLATEFLOW_HOST_HOME}:${SINGULARITYENV_TEMPLATEFLOW_HOME} \
      -B ${SCRATCH_DIR}:/work \
      -B ${FS_LICENSE}:/freesurfer \
      -B ${CODE_DIR}:/code
      $IMG_DIR/poldracklab-fmriprep_${fmriprep_ver}.sif"
jsonlist=($(ls ${BIDS_DIR}/sub-${subject}/*/*/*.json))
json=${jsonlist[-1]}
manufacturer=$(grep -oP '(?<="Manufacturer": ")[^"]*' ${json})
if [[ ${manufacturer} ==  "GE" ]]; then
	echo "Assign dummy-scans for ${manufacturer}"
	dummyscans=5
elif [[ ${manufacturer} == "Siemens" ]] || [[ ${manufacturer} == "Philips" ]]; then
	echo "Assign dummy-scans for ${manufacturer}"
    dummyscans=8
fi
mem_gb=`echo "${SLURM_MEM_PER_CPU} * ${SLURM_CPUS_PER_TASK}" | bc -l`
cmd="${SINGULARITY_CMD} /data \
      /out \
      participant \
      --participant-label ${subject} \
      -w /work/ \
      -vv \
      --omp-nthreads ${SLURM_CPUS_PER_TASK} \
      --nprocs ${SLURM_CPUS_PER_TASK} \
      --mem_mb ${mem_gb} \
      --output-spaces MNI152NLin2009cAsym:res-native fsaverage5 \
      --dummy-scans ${dummyscans} \
      --ignore slicetiming \
      --return-all-components \
      --debug compcor \
      --notrack \
      --no-submm-recon \
      --fs-license-file /freesurfer/license.txt"
echo Running task ${THISJOBVALUE}
echo Commandline: $cmd
eval $cmd
exitcode=$?
echo "sub-$subject   ${THISJOBVALUE}    $exitcode" \
      >> ${CODE_DIR}/log/${SLURM_JOB_NAME}/${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
echo Finished tasks ${THISJOBVALUE} with exit code $exitcode
rm -r ${SCRATCH_DIR}
date
exit $exitcode
