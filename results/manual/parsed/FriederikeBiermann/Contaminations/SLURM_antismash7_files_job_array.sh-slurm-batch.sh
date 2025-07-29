#!/bin/bash
#SBATCH --job-name=antismash
#SBATCH --output=/beegfs/projects/p450/out_files/Julia_antismash_%A_%a.out
#SBATCH --error=/beegfs/projects/p450/error_files/Julia_antismash_error_%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=1-00:00:00
#SBATCH --partition=batch
#SBATCH --array=0-10%100

source ~/.bashrc
conda activate /beegfs/home/fbiermann/miniconda3_supernew/envs/antismash7
input_dirs=(
   "/projects/p450/NCBI_contaminations/Contaminations/Data/Genbank_genbank_over_5000_coverage_smaller_40_with_gene_annotations/genbank/"
)  # Update with your input directories
output_parent_dir="/projects/p450/NCBI_contaminations/Contaminations/Data/Genbank_genbank_over_5000_coverage_smaller_40_with_gene_annotations_antismash_out/"  # Replace with your output parent directory
start_index=$(($SLURM_ARRAY_TASK_ID * 500))
end_index=$(($start_index + 499))
for input_dir in "${input_dirs[@]}"; do
    # Create the output directory for this input directory
    output_dir="${output_parent_dir}/$(basename "${input_dir}")"
    mkdir -p "$output_dir"
    # Get the list of files in the directory
    input_files=($(find "${input_dir}" -maxdepth 2 -type f -name "*.gb"))
    # Process each file in the current job's range
    for index in $(seq $start_index $end_index); do
        if [ $index -lt ${#input_files[@]} ]; then
            input_file="${input_files[$index]}"
            filename=$(basename "$input_file" .gb)
            # Execute the antismash script for the input file
            antismash --fullhmmer  --tigrfam --cb-knownclusters --cb-general --rre  "$input_file" --output-dir "$output_dir/$filename" 
        fi
    done
done
