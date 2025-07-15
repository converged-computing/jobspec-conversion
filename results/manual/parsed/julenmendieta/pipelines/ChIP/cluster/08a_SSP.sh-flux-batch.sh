#!/bin/bash
#FLUX: --job-name=SSP
#FLUX: -c=8
#FLUX: -t=36000
#FLUX: --urgency=16

export PATH='/home/jmendietaes/programas/miniconda3/envs/Renv/bin:$PATH'

bamsPath=$1
outpath=$2
genomeTable=$3
sspPath="/home/jmendietaes/programas/SSP/ssp_drompa.img"
export PATH="/home/jmendietaes/programas/miniconda3/envs/Renv/bin:$PATH"
module load Boost/1.77.0-GCC-11.2.0
module load Singularity/3.10.2
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT
fileNotExistOrOlder () {
    # check if the file exists of it was created with a previous bam version 
    analyse="no"
    if [ ! -e $1 ]; then
        analyse="yes"
    # only proceed if the output file is older than the bam file
    # in this way if we resequenced and kept the name the analysis 
    # will be repeated
    else
        for tfile in $2; do
            if [[ $1 -ot ${tfile} ]] ; then
                analyse="yes"
                echo $1" older than "${tfile}
            fi
        done
    fi
}
allbams=$(find ${bamsPath}/*bam -printf "${bamsPath}/%f\n" | \
            tr '\n' ' ')
allbams2=$(find ${bamsPath}/mergedReplicates/*bam -printf "${bamsPath}/mergedReplicates/%f\n" | \
            tr '\n' ' ')
allbams=$(echo $allbams $allbams2)
for bam in ${allbams}; do
    id=$(basename $bam); id=(${id//./ }); id=${id[0]}
    outfile=${id}.stats.txt
    # check if the file exists of it was created with a previous bam version 
    fileNotExistOrOlder "${outfile}" "${bam}"
    # this outputs analyse as yes or no in lowercase
    if [[ ${analyse} == "yes" ]]; then
        singularity exec ${sspPath} ssp -i ${bam} -o ${id} --odir ${outpath} \
                                        --pair -f BAM --gt ${genomeTable} \
                                        -p ${SLURM_CPUS_PER_TASK}
    fi
done
statsFiles=`find ${outpath}/*stats.txt`
statsFile1=(${statsFiles// / }); 
statsFile1=${statsFile1[0]}
head -n 1 $statsFile1 > ${outpath}/allStats_SSP.txt
for fi in ${statsFiles}; do
     tail -n 1 ${fi} >> ${outpath}/allStats_SSP.txt
done
