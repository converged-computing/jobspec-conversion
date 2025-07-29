#!/bin/bash
#SBATCH --job-name=mytestjob
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=1

module load singularitypro
mount_dir="/mnt"
code_mount_dir="/code"
code_dir="/home/dtyoung/app-test-NEMAR"
data_dir="/expanse/projects/nemar/openneuro" #$(jq -r .dir config-dataqual.json)
datasetID="ds003629" #$(jq -r .dataset config-dataqual.json)
out_dir="$code_mount_dir/test/processed" #$(jq -r .outdir config-dataqual.json)
data_path="$mount_dir/$datasetID"
echo $data_path
singularity exec --bind $data_dir:$mount_dir,$code_dir:$code_mount_dir -e docker://dtyoung/eeglab-pipeline:eeglab octave-cli $code_mount_dir/bids_dataqual.m $data_path $out_dir $code_mount_dir
