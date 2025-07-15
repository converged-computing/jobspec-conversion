#!/bin/bash
#FLUX: --job-name=wobbly-pastry-7720
#FLUX: --urgency=16

set -euo pipefail
shifter_flags="--module=none --clearenv --env=PAPERMILL_EXECUTION=True"
log_dir="/global/cfs/projectdirs/m2650/jupyter_logs/slurm"
trap \
  "{ cp "$OUT_FILE" "${log_dir}/${SLURM_JOB_ID}_$(basename "$OUT_FILE")" ; }" \
  EXIT
log="${log_dir}/${SLURM_JOB_ID}.log"
output () {
  printf "%s\n" "$1" | tee --append "$log"
}
output "start time: $(date)"
output "user: $USER"
output "input file: $IN_FILE"
output "output file: $OUT_FILE"
output "parameters: $PARAMETERS"
output "yaml parameters: $(echo "$YAML_BASE64" | base64 --decode)"
shifter $shifter_flags /bin/bash -c \
  'set -euo pipefail && \
   black --quiet --check /metatlas_image_version && \
   papermill \
     /src/notebooks/reference/RT-Alignment.ipynb \
     - \
     -p model_only True \
     --prepare-only \
     -k papermill > /dev/null'
shifter --entrypoint $shifter_flags \
  /usr/local/bin/papermill \
  -k "papermill" \
  "$IN_FILE" \
  "$OUT_FILE" \
  --parameters_base64 "$YAML_BASE64" \
  $PARAMETERS 2>&1 | tee --append "$log"
