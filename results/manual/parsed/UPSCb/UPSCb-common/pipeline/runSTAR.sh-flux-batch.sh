#!/bin/bash
#FLUX: --job-name=scruptious-punk-8787
#FLUX: -n=20
#FLUX: --queue=node
#FLUX: -t=43200
#FLUX: --urgency=16

set -eu
source ${SLURM_SUBMIT_DIR:-$(pwd)}/../UPSCb-common/src/bash/functions.sh
ulimit -n 8192
INTRONMAX=70000
GFF=
SINGLE=0
PROC=20
FORMAT="gtf"
LIMIT=10000000000
QUANT=0
UNSORTED=0
CHIMERIC=0
CRAM=1
WIGGLE=0
NoGZ="--readFilesCommand zcat"
OPTIONS="--outSAMmapqUnique 254 --outFilterMultimapNmax 100"
USAGETXT=\
"Usage:
    Paired end: $0 [option] <star singularity container> <samtools singularity container> <out dir> <genome dir> <genome fasta> <fwd file> <rv file> [--] [additional STAR arguments]
    Single end: $0 [option] -s <star singularity container> <samtools singularity container> <out dir> <genome dir> <genome fasta> <fastq file> [--] [additional STAR arguments]
	Options:
	  -b do not bam to cram
	  -c produce chimeric files
	  -d enable double pass
    -f the gtf/gff3 file format (default gtf)
    -g the path to a gtf/gff3 file
    -h print the usage
    -i add intronMotif as a SAM attribute
		-l the BAM sorting memory limit ($LIMIT)
		-m the max intron length ($INTRONMAX)
		-n no default option
		-o simple bam unsorted output
    -p number of threads to be used (default: $PROC)
		-q set for Illumina +64 Phred score
		-s if there are no reverse reads (single-end mode)
		-t quantify the transcriptome
		-w wiggle bedgraphs files
		-z input is not compressed (default is compressed)
	Notes:
		The number of arguments is only 3 when -s is set.
		-- is a special argument that stop the command line scanning for the script  options.
		It is necessary if you want to precised additional - non-default - STAR arguments.
		When the format is gff3, the exon-transcript relationship assumes a 'Parent' keylink.
"
while getopts bcdf:g:hil:m:nop:qstwz option
do
  case "$option" in
      b) CRAM=0;;
      c) OPTIONS="$OPTIONS --chimSegmentMin 1"
         CHIMERIC=1;;
      d) "$OPTIONS --twopassMode Basic";;
	    f) FORMAT=$OPTARG;;
	    g) GFF=$OPTARG;;
	    h) usage;;
	    i) OPTIONS="$OPTIONS --outSAMstrandField intronMotif";;
	    l) LIMIT=$OPTARG;;
      m) INTRONMAX=$OPTARG;;
      n) OPTIONS="";;
      o) UNSORTED=1;;
	    p) PROC=$OPTARG;;
	    q) OPTIONS="$OPTIONS --outQSconversionAdd -31";;
	    s) SINGLE=1;;
	    t) OPTIONS="$OPTIONS --quantMode TranscriptomeSAM"
	       QUANT=1;;
	    w) OPTION="$OPTIONS --outWigType bedGraph"
		     WIGGLE=1;;
		  z) NoGZ="";;
	    \?) ## unknown flag
		usage;;
  esac
done
shift `expr $OPTIND - 1`
OPTIONS="$OPTIONS $NoGZ --alignIntronMax $INTRONMAX --runThreadN $PROC"
if [ "$OPTIONS" != "" ]; then
  OPTIONS="$OPTIONS --limitBAMsortRAM $LIMIT"
fi
echo "Parsing the arguments"
ARGS=7
if [ $SINGLE == 1 ]; then
    let "ARGS = $ARGS - 1"
    FIND=".f*.gz"
else
    FIND="_[1,2].f*q.gz"
fi
[[ $# -lt $ARGS ]] && abort "This script needs 6 or 7 arguments for SE or PE data, respectively."
star=$1
shift
[[ ! -f $star ]] && abort "The first argument needs to be an existing STAR singularity container"
samtools=$1
shift
[[ ! -f $samtools ]] && abort "The first argument needs to be an existing samtools singularity container"
[[ -z ${SINGULARITY_BINDPATH:-} ]] && abort "This function relies on singularity, set the SINGULARITY_BINDPATH environment variable"
outdir=$1
shift
[[ ! -d $outdir ]] && abort "The output directory: $outdir does not exist"
genome=$1
shift
[[ ! -d $genome ]] && abort "The genome directory: $genome does not exist"
gfasta=$1
shift
[[ ! -f $gfasta ]] && abort "The genome fasta file: $gfasta does not exist"
fwd=$1
shift
[[ ! -f $fwd ]] && abort "The forward fastq file: $fwd does not exist"
[[ $SINGLE == 0 ]] && [[ ! -f $1 ]] && abort "The reverse fastq file: $1 does not exist"
[[ $SINGLE == 0 ]] && rev=$1 && shift
[[ ! -z $GFF ]] && [[ ! -f $GFF ]] && abort "The gene model gtf/gff3 file: $GFF does not exists"
[[ ! -z $GFF ]] && OPTIONS="--sjdbGTFfile $GFF $OPTIONS"
case $FORMAT in
    gff3)
    OPTIONS=" $OPTIONS --sjdbGTFtagExonParentTranscript Parent"
    ;;
    gff)
    OPTIONS=" $OPTIONS --sjdbGTFtagExonParentTranscript Parent"
    ;;
    gtf);;
    #nothing to do
    *)
	abort "There are only 2 supported format, gtf or gff3"
esac
if [ $UNSORTED -eq 1 ]; then
  OPTIONS="$OPTIONS --outSAMtype BAM Unsorted --outSAMattributes None"
else
  OPTIONS="$OPTIONS --outReadsUnmapped Fastx --outSAMtype BAM SortedByCoordinate --outSAMattributes All"
fi
echo "Processing"
if [ ! -d $outdir ]; then
    mkdir -p $outdir
fi
[[ $# != 0 ]] && shift
bnam=$(basename ${fwd//$FIND/})
fnam=$outdir/$bnam
echo "Aligning"
if [ $SINGLE == 1 ]; then
    singularity exec $star STAR --genomeDir $genome --readFilesIn $fwd --outFileNamePrefix $fnam $OPTIONS $@
else
    singularity exec $star STAR --genomeDir $genome --readFilesIn $fwd $rev --outFileNamePrefix $fnam $OPTIONS $@
fi
echo "Logging"
mkdir -p ${fnam}_logs
mv ${fnam}Log.* ${fnam}_logs
mkdir -p ${fnam}_junctions
mv ${fnam}SJ* ${fnam}_junctions
[[ $CHIMERIC -eq 1 ]] && mv ${fnam}Chimeric.out.junction ${fnam}_junctions
if [ $WIGGLE -eq 1 ]; then
	echo "Wiggling"
	mkdir -p ${fnam}_bedgraphs
	mv ${fnam}Signal.*.bg ${fnam}_bedgraphs
fi
echo "Renaming"
if [ $UNSORTED -eq 0 ]; then
  mv ${fnam}Aligned.sortedByCoord.out.bam ${fnam}_STAR.bam
  if [ $SINGLE == 0 ]; then
    mv ${fnam}Unmapped.out.mate1 ${fnam}_Unmapped_1.fq
    mv ${fnam}Unmapped.out.mate2 ${fnam}_Unmapped_2.fq
  else
    mv ${fnam}Unmapped.out.mate1 ${fnam}_Unmapped.fq
  fi
  ## compress files (we would only need 2 CPUS, but what if PROC is set to 1)
  find $outdir -name "${bnam}_Unmapped*.fq" -print0 | xargs -P $PROC -0 -I {} gzip -f {}
else
  mv ${fnam}Aligned.out.bam ${fnam}_STAR.bam
fi
if [ $QUANT == 1 ]; then
  mv ${fnam}Aligned.toTranscriptome.out.bam ${fnam}_STAR_Transcriptome.bam
  singularity exec $samtools samtools sort -@ $PROC -n ${fnam}_STAR_Transcriptome.bam -o ${fnam}_STAR_Transcriptome.sorted.bam
  rm ${fnam}_STAR_Transcriptome.bam
  mv ${fnam}_STAR_Transcriptome.sorted.bam ${fnam}_STAR_Transcriptome.bam
fi
if [ $CRAM -eq 1 ]; then
  if [ $CHIMERIC -eq 1 ]; then
    singularity exec $samtools samtools view -CT $gfasta ${fnam}Chimeric.out.sam | \
    singularity exec $samtools samtools sort -@ $PROC - -o ${fnam}_STAR_Chimeric.cram
    singularity exec $samtools samtools index ${fnam}_STAR_Chimeric.cram
  fi
  ## convert the output BAM in CRAM
  singularity exec $samtools samtools view -CT $gfasta -o ${fnam}_STAR.cram ${fnam}_STAR.bam
  ## index the CRAMs
  echo "Indexing"
  singularity exec $samtools samtools index ${fnam}_STAR.cram
  ## cleanup
  echo "Cleaning"
  rm ${fnam}_STAR.bam
else
  if [ $CHIMERIC -eq 1 ]; then 
    singularity exec $samtools samtools view -b ${fnam}Chimeric.out.sam | \
    singularity exec $samtools samtools sort -@ $PROC - -o ${fnam}_STAR_Chimeric.bam
    singularity exec $samtools samtools index ${fnam}_STAR_Chimeric.bam
  fi
  echo "Indexing"
  singularity exec $samtools samtools index ${fnam}_STAR.bam
fi
echo "Cleaning"
[[ $CHIMERIC -eq 1 ]] && rm ${fnam}Chimeric.out.sam
rm -rf ${fnam}_STARtmp/
