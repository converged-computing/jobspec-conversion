flux
#!/bin/bash
#flux: -N 1
#flux: -n 1
#flux: -c 1
#flux: -t 2:00:00

# Original PBS job name: par_combine_unpaired_Jineo
# In Flux, job name is typically set at submission time, e.g., flux submit --job-name=my_job_name script.sh

# Original PBS email options (-m abe, -M rmoran@umn.edu) are not directly translated.
# Flux handles notifications differently, often at the system or instance level.

# Original PBS output joining (-j oe) is the default behavior in Flux.

# Original PBS queue (-q mesabi) is not directly translated.
# Flux matches resources based on requests; specific queues/partitions are configured in Flux itself.

#This script is used to combine unpaired reads from R1 and R2 fastq files prior to alignment with bwa


#       The home folder
export HOME=/home/mcgaughs/shared/Datasets/Reads_ready_to_align/Jineo

# Load the parallel module. Assumes 'module' command is available in the Flux job environment.
module load parallel

#       Define a bash function for doing the processing
parcomb() {
        #sample basename from the <POP>_SampID.txt file supplied to parallel with the -a flag
        SAMP=${1}
        cat ${SAMP}_adtrim_trim_unpair_R1.fastq.gz ${SAMP}_adtrim_trim_unpair_R2.fastq.gz > ${SAMP}_adtrim_trim_unpair_all.fastq.gz
}

#   Export function so we can call it with parallel
export -f parcomb

#       cd into the reads directory
cd ${HOME}

# Run the parallel command.
# Given the resource request of 1 core, 'parallel' will effectively run 'parcomb' instances sequentially.
parallel --joblog Jineo_combunpair_parallel_logfile.txt -a Jineo_SampID.txt parcomb