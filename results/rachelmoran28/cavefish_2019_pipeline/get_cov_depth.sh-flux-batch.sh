#!/bin/bash
#flux: -N 1
#flux: -n 12
#flux: --mem-per-node=22G 
#flux: -t 24:00:00
#flux: --job-name=bamg_cov_depth
#flux: -C mesabi  # Assuming 'mesabi' PBS queue maps to a Flux resource constraint/feature 'mesabi'.
                 # This may need adjustment based on the specific Flux site configuration for queues/partitions.
#flux: --output=bamg_cov_depth.%J.out # Merges stdout and stderr by default if --error is not specified.

module load parallel/20160822
module load samtools/1.7

#Can use any bam aligned to the cavefish genome for this step
export CAVE_GENOME_SIZE=$(samtools view -H /home/mcgaughs/shared/Datasets/bams/cave.fish.reference.genome/v1_cavefish_raw_bams/Jineo_1_dupsmarked_rgadd.bam | grep -P '^@SQ' | cut -f 3 -d ':' | awk '{sum+=$1} END {print sum}')
export HOME=/home/mcgaughs/shared/Datasets/bams/cave.fish.reference.genome/v1_cavefish_raw_bams

#Can use any bam aligned to the surface fish genome for this step
#export SURFACE_GENOME_SIZE=$(samtools view -H /home/mcgaughs/shared/Datasets/bams/surface.fish.reference.genome/v2_surfacefish_raw_bams/Jineo_1_dupsmarked_rgadd.bam | grep -P '^@SQ' | cut -f 3 -d ':' | awk '{sum+=$1} END {print sum}')
#export HOME=/home/mcgaughs/shared/Datasets/bams/surface.fish.reference.genome/v2_surfacefish_raw_bams


bam_depth() {
    BAM=${1}
    BASE=$(basename $BAM)
    ONAME=${BASE/.bam/}
    # The awk script calculates coverage and prints. This output is appended to the file.
    samtools depth -aa ${BAM} | awk -v name=$ONAME -v size=$CAVE_GENOME_SIZE '{sum+=$3} END {print "Cave\t"name"\t"sum/size}' >> ${HOME}/cave_genome_depths.txt
}

export -f bam_depth

echo -n "Ran: "
date

# The '>' redirection on the 'parallel' command line ensures that ${HOME}/cave_genome_depths.txt
# is truncated or created empty before 'parallel' starts. Each 'bam_depth' call then appends to it.
# GNU 'parallel' will utilize the cores allocated to the job.
find /home/mcgaughs/shared/Datasets/bams/cave.fish.reference.genome/v1_cavefish_raw_bams -type f -name *.bam | parallel bam_depth > ${HOME}/cave_genome_depths.txt
#find /home/mcgaughs/shared/Datasets/bams/surface.fish.reference.genome/v2_surfacefish_raw_bams -type f -name *.bam | parallel bam_depth > ${HOME}/surface_genome_depths.txt

echo -n "Done: "
date