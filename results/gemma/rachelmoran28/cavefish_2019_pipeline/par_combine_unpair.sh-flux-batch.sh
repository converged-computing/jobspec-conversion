#!/bin/bash
# Flux batch script for par_combine_unpaired_Jineo

# Set job name
# Flux uses -n for job name
# Flux does not have a direct equivalent to -N
# Job name is set via the script name or manually in the queue manager

# Resource requests
# Flux uses --nodes, --cpus, --time, --memory
# ppn=1 translates to 1 cpu per node.  We request 1 node with 1 cpu.
# Flux does not have a direct equivalent to -q (queue) or -M (email)

# Set walltime
# Flux uses --time in HH:MM:SS format
export FLUX_TIME=02:00:00

# Set number of nodes and cpus
export FLUX_NODES=1
export FLUX_CPUS=1

# Set memory (if known, otherwise omit)
# export FLUX_MEMORY=4G

# Software modules
module load parallel

# Define the home directory
export HOME=/home/mcgaughs/shared/Datasets/Reads_ready_to_align/Jineo

# Define the bash function
parcomb() {
        SAMP=${1}
        cat ${SAMP}_adtrim_trim_unpair_R1.fastq.gz ${SAMP}_adtrim_trim_unpair_R2.fastq.gz > ${SAMP}_adtrim_trim_unpair_all.fastq.gz
}

# Export the function
export -f parcomb

# Change directory
cd ${HOME}

# Run parallel
parallel --joblog Jineo_combunpair_parallel_logfile.txt -a Jineo_SampID.txt parcomb