#!/bin/bash
#SBATCH --job-name=launch_cci_pipeline
#SBATCH --output=slurm_out/%x_%j.out
#SBATCH --error=slurm_out/%x_%j.out
#SBATCH --mail-user=joan.kant@uhn.ca
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=02:00:00

module load java/18
base_dir="/cluster/projects/gaitigroup/Users/Joan/"
project_dir="${base_dir}/scrnaseq-cellcomm"
input_file="${project_dir}/data/example_data.rds"
output_dir="${project_dir}/test_pipeline"
init_step=1
sample_var="Sample"
annot="seurat_annotations"
condition_var="Condition"
patient_var="Patient"
min_patients=2
min_cells=70
is_confident=0
n_perm=10
min_pct=0.10
alpha=0.05
nf_exec="${HOME}/nextflow-23.04.3-all"
work_dir="${project_dir}/nf-work"
nf_profile="conda"
outdir="${project_dir}/nf-logs"
mkdir -p "${output_dir}"
mkdir -p "${outdir}"
echo "Running pipeline..."
${nf_exec} run ${project_dir} \
    -profile ${nf_profile} \
    -w ${work_dir} \
    --input_file $input_file \
    --sample_var ${sample_var} \
    --annot ${annot} \
    --min_cells ${min_cells} \
    --n_perm ${n_perm} \
    --min_pct ${min_pct} \
    --alpha $alpha \
    --init_step $init_step \
    --condition_var $condition_var \
    --patient_var $patient_var \
    --min_patients $min_patients \
    --is_confident ${is_confident} \
    --outdir ${outdir} \
    --output_dir ${output_dir}
echo "Done!"
