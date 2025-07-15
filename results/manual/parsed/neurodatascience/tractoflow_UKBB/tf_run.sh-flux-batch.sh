#!/bin/bash
#FLUX: --job-name=dinosaur-dog-7373
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --urgency=16

export chunk='${chunk}'
export SINGULARITY_BIND=''

helpstr="$(basename $0) [-c,--chunk INT] [-o,--out PATH] --root DIR
Processes the specified BIDS DWI dataset using the Tractoflow pipeline.
where:
  -r,--root DIR           Directory containing Tractoflow-related files (ext3 images, output directory, files to overlay).
  -s,--singularity PATH   Path to the Tractoflow Singularity image.
  -d,--data
  -c,--chunk INT          Optional. Specify the subject chunk that should be run. Expects values 0-10000. Default: SLURM_TASK_ARRAY_ID
  -o,--out PATH           Optional. Path to the ext3 image to write. Default: {root}/ext3_images/TF_raw/TF-raw-{chunk}.img
Example:
sbatch --account ACCOUNT ${0} --root TF_RUN --out /TF-raw-00000.img --singularity tractoflow.sif --data project/ukbb/imaging
"
chunk=$(printf "%05d" "${SLURM_ARRAY_TASK_ID}")
OUT_IMAGE=""
while (( "$#" )); do
  case "$1" in
    -h|--help)
      echo "${helpstr}"
      exit 0
      ;;
    -c|--chunk)
      chunk=$(printf "%05d" "${2}")
      if [ -n "${SLURM_ARRAY_TASK_ID}" ]; then
        >&2 echo "Chunk is defined, but job is an array. Either remove --chunk or do not submit as an array."
        exit 1
      fi
      shift 2
      ;;
    -r|--root)
      TASK_ROOT="${2}"
      shift 2
      ;;
    -o|--out)
      OUT_IMAGE="${2}"
      shift 2
      ;;
    -s|--singularity)
      SING_TF_IMAGE="${2}"
      shift 2
      ;;
    -d|--data)
      UKBB_SQUASHFS_DIR="${2}"
      shift 2
      ;;
    *)
      >&2 echo "Unrecognized option ${1}"
      exit 1
      ;;
  esac
done
export chunk="${chunk}"
export SINGULARITY_BIND=""
if [ -z "${OUT_IMAGE}" ]; then
  OUT_IMAGE=${TASK_ROOT}/ext3_images/TF_raw/TF-raw-${chunk}.img
fi
OUT_ROOT="/TF_OUT/${chunk}"
SYMTREE="${TASK_ROOT}/ext3_images/symtree.squashfs"
BIDS_DIR="${TASK_ROOT}/fake_bids/dwi_subs-${chunk}"
TRACE_DIR="${TASK_ROOT}/sanity_out/nf_traces"
TRACE_FILE="${TRACE_DIR}/trace-${chunk}.txt"
LOG_DIR="${TASK_ROOT}/logs/${chunk}"
mkdir -p ${LOG_DIR}
TRACE_FILE="${LOG_DIR}/trace.txt"
cd ${LOG_DIR}
if [ ! -d "${TASK_ROOT}" ]; then
  >&2 echo "Error: ${TASK_ROOT} does not exist"
  exit 1
fi
if [ ! -d "${BIDS_DIR}" ]; then
  >&2 echo "Error: ${BIDS_DIR} does not exist"
  exit 1
fi
if [ -z "${SING_TF_IMAGE}" ]; then
  SING_TF_IMAGE="${TASK_ROOT}/tractoflow.sif"
  echo "Warning: Defaulting to ${SING_TF_IMAGE} for Singularity image."
fi
if [ -z "${UKBB_SQUASHFS_DIR}" ]; then
  UKBB_SQUASHFS_DIR=/project/6008063/neurohub/ukbb/imaging
fi
UKBB_SQUASHFS="
  neurohub_ukbb_dwi_ses2_0_bids.squashfs
  neurohub_ukbb_dwi_ses2_1_bids.squashfs
  neurohub_ukbb_dwi_ses2_2_bids.squashfs
  neurohub_ukbb_t1_ses2_0_bids.squashfs
  neurohub_ukbb_t1_ses3_0_bids.squashfs
  neurohub_ukbb_participants.squashfs
  neurohub_ukbb_t1_ses2_0_jsonpatch.squashfs
"
SING_BINDS=" -H ${OUT_ROOT} -B ${TASK_ROOT} -B ${OUT_IMAGE}:${OUT_ROOT}:image-src=/upper "
UKBB_OVERLAYS=$(echo "" $UKBB_SQUASHFS | sed -e "s# # --overlay $UKBB_SQUASHFS_DIR/#g")
DWI_OVERLAYS="--overlay ${SYMTREE}"
echo "Starting run-${chunk}" | tee >> ${TRACE_FILE}
module load singularity/3.7
SINGULARITYENV_NXF_CLUSTER_SEED=$(shuf -i 0-16777216 -n 1) singularity -d exec --cleanenv ${SING_BINDS} ${UKBB_OVERLAYS} ${DWI_OVERLAYS} ${SING_TF_IMAGE} \
  nextflow -q run /tractoflow/main.nf     \
  --bids          "${BIDS_DIR}"           \
  --output_dir    "${OUT_ROOT}"           \
  -w              "${OUT_ROOT}"/work      \
  --dti_shells    "1 1000"                \
  --fodf_shells   "0 1000 2000"           \
  --step          0.5                     \
  --mean_frf      false                   \
  --set_frf       true                    \
  --save_seeds    false                   \
  -profile        fully_reproducible      \
  -resume                                 \
  -with-trace     "${TRACE_FILE}"         \
  --processes     4                       \
  --processes_brain_extraction_t1 1       \
  --processes_denoise_dwi         2       \
  --processes_denoise_t1          2       \
  --processes_eddy                1       \
  --processes_fodf                2       \
  --processes_registration        1       \
