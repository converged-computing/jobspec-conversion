# Flux batch script equivalent

# Resources
# Flux uses a different syntax for resource requests.
# This translates to 1 node with 12 cores and 22GB of memory.
# Flux doesn't have a direct equivalent to PBS queues, but you can use
# resource filters to target specific hardware.  This example assumes
# a default execution environment.

# Flux requires a command to run.  We'll wrap the original script in bash.
# The -n option specifies the number of tasks (cores) to use.
# The -c option specifies the number of cores per task.
# The --mem option specifies the memory per task.
# The --time option specifies the walltime.

# Flux doesn't have a direct equivalent to PBS's job notifications.
# These would need to be handled separately (e.g., with a script that
# monitors job status).

# Flux doesn't have a direct equivalent to PBS's module command.
# You'll need to ensure the necessary software is available in the
# execution environment or load it within the script.

# The following assumes the necessary modules are available in the environment.
# If not, you'll need to add commands to load them here.

#!/bin/bash

# Set environment variables
CAVE_GENOME_SIZE=$(samtools view -H /home/mcgaughs/shared/Datasets/bams/cave.fish.reference.genome/v1_cavefish_raw_bams/Jineo_1_dupsmarked_rgadd.bam | grep -P '^@SQ' | cut -f 3 -d ':' | awk '{sum+=$1} END {print sum}')
HOME=/home/mcgaughs/shared/Datasets/bams/cave.fish.reference.genome/v1_cavefish_raw_bams

# Define the bam_depth function
bam_depth() {
    BAM=${1}
    BASE=$(basename $BAM)
    ONAME=${BASE/.bam/}
    samtools depth -aa ${BAM} | awk -v name=$ONAME -v size=$CAVE_GENOME_SIZE '{sum+=$3} END {print "Cave\t"name"\t"sum/size}' >> ${HOME}/cave_genome_depths.txt
}

export -f bam_depth

echo -n "Ran: "
date

find /home/mcgaughs/shared/Datasets/bams/cave.fish.reference.genome/v1_cavefish_raw_bams -type f -name *.bam | parallel bam_depth > ${HOME}/cave_genome_depths.txt

echo -n "Done: "
date