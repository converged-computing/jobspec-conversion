#!/bin/bash
#FLUX: --job-name=objectsGNN_getStrokes
#FLUX: -c=4
#FLUX: --queue=adam
#FLUX: -t=14400
#FLUX: --urgency=16

set -u
if [[ "$#" -lt 2 ]] || [[ "$1" = "--help" ]] ; then
  printf '%s\n' "usage: $0 input_curriculum_dir output_curriculum_dir"
  exit 1
else
  input_curriculum_dir=$1
  output_curriculum_dir=$2
  shift 2
fi
shim_path=/nas/gaia/adam/matlab/bin/glnxa64/glibc-2.17_shim.so
LD_PRELOAD="$shim_path" python shape_stroke_extraction.py "$input_curriculum_dir" "$output_curriculum_dir" "$@"
