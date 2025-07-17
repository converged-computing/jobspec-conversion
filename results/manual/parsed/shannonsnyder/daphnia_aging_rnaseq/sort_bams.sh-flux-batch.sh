#!/bin/bash
#FLUX: --job-name=sort_bams
#FLUX: --queue=memory
#FLUX: -t=86400
#FLUX: --urgency=16

 ### Number of CPU cores per task                                                                                                                       
input_dir="/home/ssnyder3/nereus/aging_rnaseq/star_alignment/pulex/aligned_reads"
mkdir -p sorted_bams
output_dir="/home/ssnyder3/nereus/aging_rnaseq/star_alignment/pulex/aligned_reads/sorted_bams"
for bam_file in "$input_dir"/*.bam; do
    # Get the base name of the BAM file                                                                                                                 
    base_name=$(basename "$bam_file" .bam)
    # Define the output sorted BAM file name                                                                                                            
    sorted_bam="${output_dir}/${base_name}_sorted.bam"
    # Use samtools to sort the BAM file                                                                                                                 
    samtools sort -o "$sorted_bam" "$bam_file"
    echo "Sorted BAM file created: $sorted_bam"
done
echo "All BAM files sorted and renamed."
