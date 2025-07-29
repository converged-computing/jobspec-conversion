#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

module add dcm2niix
data_dir=/bgfs/bchandrasekaran/krs228/data/FLT/
software_dir=/bgfs/bchandrasekaran/krs228/software/
sub=$1
echo "converting $1"
heudiconv -d "${data_dir}/sourcedata/dicoms/{subject}/*/scans/*/resources/DICOM/files/*" \
  -s $sub \
  -c dcm2niix \
  --bids \
  --grouping all \
  -ss 1 \
  -o $data_dir/data_bids \
  -f heuristic.py
