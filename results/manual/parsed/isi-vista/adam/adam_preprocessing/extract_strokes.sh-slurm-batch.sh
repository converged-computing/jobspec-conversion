#!/bin/bash
#SBATCH --job-name=objectsGNN_getStrokes
#SBATCH --account=adam
#SBATCH --output=R-%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32g
#SBATCH --time=04:00:00
#SBATCH --partition=adam

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
