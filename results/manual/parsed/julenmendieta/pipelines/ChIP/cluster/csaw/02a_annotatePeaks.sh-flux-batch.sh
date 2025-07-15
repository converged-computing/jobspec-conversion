#!/bin/bash
#FLUX: --job-name=AnnotatePeaks
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --urgency=16

export PATH='/home/jmendietaes/programas/miniconda3/bin:$PATH'

basePath="/home/jmendietaes/data/2021/chip/allProcessed/furtherAnalysis/subsampled_noIgG/binCalling"
inpath="${basePath}/binnedPeaks/consensus"
outpath="${basePath}/Annot/consensus"
gtfFile=/home/jmendietaes/data/2021/singleCell/additionalFiles/refdata-gex-mm10-2020-A/genes/genes.gtf
repeatsPath=/beegfs/easybuild/CentOS/7.5.1804/Skylake/software/Homer/4.10-foss-2018b/data/genomes/mm10/mm10.repeats
scriptsPath="/home/jmendietaes/programas/pipelines"
species="mm"
speciesGenome="mm10"
export PATH="/home/jmendietaes/programas/miniconda3/envs/Renv/bin:$PATH"
export PATH="/home/jmendietaes/programas/miniconda3/bin:$PATH"
module load Homer/4.10-foss-2018b
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
if [[ $gtfFile == "FALSE" ]]; then
    extraAnnot=""
else
    extraAnnot="-gtf ${gtfFile}"
fi
if [ ! -e ${outpath} ]; then
	mkdir -p ${outpath}
fi
echo -e "Starting consensus peak annotations ------------------------------\n"
consensusFiles=$(find ${inpath}/*tsv -printf "${inpath}/%f\n" | \
            tr '\n' ' ')
chip="allmerged"
for binnedPeaks in ${consensusFiles}; do
    peaktype="binnedPeak"
    prefix=$(basename $binnedPeaks | cut -d '.' -f 1 | sed 's/allChIPCounts_//g')
    prefix="${chip}_${peaktype}_consensusPeaks_${prefix}"
    ## First part
    mergecols=`seq 2 9 | tr '\n' ','`
    expandparam=''
    ## Second part
    # check if the file exists or it was created with a previous peaks version 
    boolAnotMatr=${outpath}/${prefix}.boolean.annotatePeaks.txt
    fileNotExistOrOlder "${boolAnotMatr}" "${binnedPeaks}"
    # this outputs analyse as yes or no in lowercase
    if [[ ${analyse} == "yes" ]]; then
        annotatePeaks.pl \
                ${binnedPeaks} \
                ${speciesGenome} \
                -gid \
                ${extraAnnot} \
                -cpu ${SLURM_CPUS_PER_TASK} \
                -annStats ${outpath}/${prefix}.annotateStats.txt \
                > ${outpath}/${prefix}.annotatePeaks.txt
        cut -f2- ${outpath}/${prefix}.annotatePeaks.txt | \
            awk 'NR==1; NR > 1 {print $0 | "sort -T '.' -k1,1 -k2,2n"}' | \
            cut -f6- > ${outpath}/tmp.txt
        paste ${binnedPeaks} \
            ${outpath}/tmp.txt > ${boolAnotMatr}
        # We add a column for annotations regarding repeat elements
        if [[ $repeatsPath != "FALSE" ]]; then
            annotatePeaks.pl \
                    ${binnedPeaks} \
                    ${speciesGenome} \
                    -gid \
                    -ann ${repeatsPath} \
                    -cpu ${SLURM_CPUS_PER_TASK} \
                    > ${outpath}/${prefix}.annotatePeaks_rep.txt
            cut -f2- ${outpath}/${prefix}.annotatePeaks_rep.txt | \
                awk 'NR==1; NR > 1 {print $0 | "sort -T '.' -k1,1 -k2,2n"}' | \
                cut -f7 > ${outpath}/tmp.txt
            rm ${outpath}/${prefix}.annotatePeaks_rep.txt
            # rename header and paste to consensus table
            sed -i 's/Annotation/Repeats Annotation/g' ${outpath}/tmp.txt
            paste ${boolAnotMatr} \
                ${outpath}/tmp.txt > ${outpath}/tmp2.txt
            mv ${outpath}/tmp2.txt ${boolAnotMatr}
        fi
    fi
done
echo -e "consensus peak annotations - Finished ---------------------\n"
