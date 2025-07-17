#!/bin/bash
#FLUX: --job-name=tadbitTools
#FLUX: -c=8
#FLUX: --queue=medium
#FLUX: -t=172800
#FLUX: --urgency=16

filesPath='/home/jmendietaes/data/2021/microC/sequencedData/merge_RUN208-RUN212/demux_fastq'
genome='/home/jmendietaes/referenceGenomes/mm10_reordered/mm10.reordered.fa'
chromCheck=$(for n in {{1..19},X}; do echo chr${n}; done)
gem_index_path='/home/jmendietaes/referenceGenomes/mm10_reordered/gem2Index/mm10.reordered.gem'
mapper=gem
mapBin="/home/jmendietaes/programas/GEM/GEM-binaries-Linux-x86_64-core_i3-20121106-022124/gem-mapper"
path='/home/jmendietaes/data/2021/microC/allProcessed/TADbitOut/'
module load Java/11.0.2
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT
nthreads=$SLURM_CPUS_PER_TASK
FILES=($(cat ${filesPath}/samplesNames.txt))
filename=${FILES[$SLURM_ARRAY_TASK_ID - 1]}
read1_path="${filesPath}/${filename}_R1_001.fastq.gz"
read2_path="${filesPath}/${filename}_R2_001.fastq.gz"
finalOut=${path}/${filename}
mkdir -p ${finalOut}
echo "Align read 1"
tadbit map -w ${finalOut} --iterative --mapper ${mapper} --mapper_binary ${mapBin} \
           --fastq ${read1_path} --index ${gem_index_path} --renz NONE \
           --read 1 -C ${nthreads} --noX  #--mapper_param "--alignment-local-min-identity 15"
echo
echo "Align read 2"
tadbit map -w ${finalOut} --iterative --mapper ${mapper} --mapper_binary ${mapBin} \
           --fastq ${read2_path} --index ${gem_index_path} --renz NONE \
           --read 2 -C ${nthreads} --noX  #--mapper_param "--alignment-local-min-identity 15"
echo
echo "Parsing"
tadbit parse -w ${finalOut} --genome ${genome} --noX --compress_input
echo
echo "Filtering"
tadbit filter -w ${finalOut} -C ${nthreads} --noX  --apply 1 3 4 7 9 10 \
            --clean --valid --compress_input
echo
echo "normalize"
tadbit normalize -w ${finalOut} --resolution 50000 -C ${nthreads} --noX --valid
tadbit normalize -w ${finalOut} --resolution 100000 -C ${nthreads} --noX --valid
tadbit normalize -w ${finalOut} --resolution 10000 -C ${nthreads} --noX --valid
echo "TAD calling"
for chrom in ${chromCheck}; do 
    tadbit segment -w ${finalOut} -r 50000 --noX --only_tads -C ${nthreads} -c $chrom; 
done
echo
echo "Compartments"
for chrom in ${chromCheck}; do
    tadbit segment -w ${finalOut} -r 100000 --noX --only_compartments \
                -C ${nthreads} --ev_index 1 --smoothing_window 3 \
                -c $chrom --savecorr --fasta ${genome}
    tadbit segment -w ${finalOut} -r 100000 --noX --only_compartments \
                -C ${nthreads} --ev_index 2 --smoothing_window 3 \
                -c $chrom --savecorr --fasta ${genome}
done
cat /home/jmendietaes/jobsSlurm/outErr/tadbitTools_${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID}.out >> ${finalOut}/${filename}_TADbit_output.txt
