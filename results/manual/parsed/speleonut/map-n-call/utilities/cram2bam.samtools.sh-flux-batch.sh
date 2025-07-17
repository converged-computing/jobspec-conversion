#!/bin/bash
#FLUX: --job-name=CRAM2BAM
#FLUX: -n=8
#FLUX: --queue=icelake,a100cpu
#FLUX: -t=19800
#FLUX: --urgency=16

userDir="/hpcfs/users/${USER}"
refDir="/hpcfs/groups/phoenix-hpc-neurogenetics/RefSeq"
delBamFile=false
modList=("SAMtools/1.17-GCC-11.2.0")
usage()
{
echo "# bam2cram.samtools.sh convert a BAM to CRAM file.
"
}
select_genome_build()
{
case "${genomeSize}" in
    3099922541 )    buildID="GRCh38"
                    genomeBuild="$refDir/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz"
                    ;;
    3217346917 )    buildID="hs38DH"
                    genomeBuild="$refDir/hs38DH.fa"
                    ;;
    3137454505 )    buildID="hs37d5"
                    genomeBuild="$refDir/hs37d5.fa.gz"
                    ;;
    2730871774 )    buildID="GRCm38"   
                    genomeBuild="$refDir/GRCm38_68.fa"
                    ;;
    3117463893 )    buildID="CHM13v2"
                    genomeBuild="$refDir/T2T_CHM13v2.0.ucsc.ebv.fa.gz"
                    ;;
    3137161264 )    buildID="hg19"
                    genomeBuild="$refDir/ucsc.hg19.fasta"
                    ;;
    3105715063 )    buildID="GRCh38.hs38d1"
                    genomeBuild="$refDir/GCA_000001405.15_GRCh38_no_alt_plus_hs38d1_analysis_set.fna.gz"
                    ;;
    3099750718 )    buildID="GRCh38"
                    genomeBuild="$refDir/Homo_sapiens.GRCh38.dna.primary_assembly.fa"
                    ;;
    3031042417 )    buildID="GRCh38.blacklist"
                    genomeBuild="$refDir/Homo_sapiens.GRCh38.dna.primary_assembly.fa.r101.s501.blacklist.gz"
                    ;;
    3101804741 )    buildID="hg19_1stM_unmask_ran_all"
                    genomeBuild="$refDir/hg19_1stM_unmask_ran_all.fa"
                    ;;
    * )         echo "## ERROR: Genome length $genomeSize for ${bamFile[SLURM_ARRAY_TASK_ID]} was not matched, you may need to specify the genome build directly using the -g flag."
                exit 1
                ;;
esac
echo "## INFO: The CRAM file ${bamFile[SLURM_ARRAY_TASK_ID]} was likely mapped to $buildID corresponding to the refseq $genomeBuild."
}
while [ "$1" != "" ]; do
    case $1 in
        -b )    shift
                bamFile=$1
                ;;
        -g )    shift
                genomeBuild=$1
                ;;
        -o )    shift
                outDir=$1
                ;;
        -i )    shift
                inputFile=$1
                ;;
        --delete )  shift
                    delBamFile=true
                    ;;
        -h | --help )   for mod in "${modList[@]}"; do
                            module load $mod
                        done
                        samtools view
                        module unload ${modList[1]}
                        module unload ${modList[0]}
                        usage
                        exit 0
                        ;;
        * )     for mod in "${modList[@]}"; do
                    module load $mod
                done
                samtools view
                module unload ${modList[1]}
                module unload ${modList[0]}
                usage
                exit 1
    esac
    shift
done
if [ ! -z "$inputFile" ]; then
    readarray -t bamFile < $inputFile
fi	
if [ -z "${bamFile[SLURM_ARRAY_TASK_ID]}" ]; then # If bamFile not specified then do not proceed
    usage
    echo "## ERROR: You need to specify -b /path/to/bam/file.cram
    # -b <arg>    REQUIRED: Path to your CRAM file"
    exit 1
fi
baseBamFile=$( basename ${bamFile[SLURM_ARRAY_TASK_ID]} .cram )
bamDir=$( dirname ${bamFile[SLURM_ARRAY_TASK_ID]} )
baiFile=${bamFile[SLURM_ARRAY_TASK_ID]}.crai
for mod in "${modList[@]}"; do
    module load $mod
done
if [ -z "$genomeBuild" ]; then # If genome not specified then do not proceed
    genomeSize=$(samtools view -H ${bamFile[SLURM_ARRAY_TASK_ID]} | grep @SQ | cut -f3 | cut -f2 -d":" | awk '{s+=$1} END {printf "%.0f\n", s}' -)
    select_genome_build
fi
if [ -z "$outDir" ]; then # If output directory not specified then make one up
    outDir=${bamDir}
    echo "## INFO: You didn't specify an output directory so I'm going to put your files here:
    $outDir"
fi
if [ ! -d "$outDir" ]; then
    mkdir -p $outDir
fi
samtools view -T ${genomeBuild} -b -@8 -o ${outDir}/${baseBamFile}.bam ${bamFile[SLURM_ARRAY_TASK_ID]}
samtools index ${outDir}/${baseBamFile}.bam
if "$delBamFile"; then
    if [ -f "${outDir}/${baseBamFile}.bam.bai" ]; then
        rm ${bamFile[SLURM_ARRAY_TASK_ID]} ${baiFile}
        echo "## INFO: Original CRAM and CRAI file ${bamFile[SLURM_ARRAY_TASK_ID]} have been removed as per your request."
    else
        echo "## ERROR: Something may have gone wrong during the conversion, the .bai file was not created.  Your original CRAM file has not been deleted"
        exit 1
    fi
else
    echo "## INFO: CRAM to BAM conversion completed.  Once you have finished working with the BAM please consider removing it and using CRAM format for long-term storage."
fi
