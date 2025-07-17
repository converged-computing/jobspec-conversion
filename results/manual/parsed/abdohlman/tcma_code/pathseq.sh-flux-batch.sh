#!/bin/bash
#FLUX: --job-name=lovely-leopard-5530
#FLUX: -c=16
#FLUX: -t=0
#FLUX: --urgency=16

export JVM_ARGS='-Xms1024m -Xmx1024m'

echo "[ Starting Pipeline ]"
mkdir -p slurmlog
module load samtools java/1.8.0_45-fasrc01
export JVM_ARGS="-Xms1024m -Xmx1024m"
GATK_HOME=/home/abd30/gatk-4.0.3.0
BASEDIR=/data/shenlab/abd/TCGA_microbiome
HOSTDIR=$BASEDIR/pathseq_bundle/host_ref
PATHDIR=$BASEDIR/pathseq_bundle/pathogen_ref
TOKENFILE=$1 # download token from GDC portal
MANIFEST=$2 # download manifest from the GDC portal
LINENUM=$SLURM_ARRAY_TASK_ID # slurm env. variable refers to manifest row number / file
ASSAY=$( echo $MANIFEST | cut -d '.' -f2 )
PROJECT=$( echo $MANIFEST | cut -d '.' -f3 )
TOKEN=$( cat $TOKENFILE )
OUTDIR=$BASEDIR/pathseq_out/$PROJECT/$ASSAY # Pathseq output here
TMPDIR=$BASEDIR/tmp/$PROJECT/$ASSAY # TCGA bam files here
QCINDIR=$OUTDIR/flagstats # Flagstats for TCGA bam files 
QCOUTDIR=$OUTDIR/flagstats_out # Flagstats for PathSeq output bam files
mkdir -p $OUTDIR $TMPDIR $QCINDIR $QCOUTDIR $OUTDIR
if [ ! -z "$3" ]; then MIN=$3;
elif [ $ASSAY = "RNA" ]; then MIN=40;
elif [ $ASSAY = "miRNA" ]; then MIN=15;
else MIN=50; fi
UUID=$(cut -f1 $2 | sed -n $(($LINENUM + 2))p)
FILENAME=$(cut -f2 $2 | sed -n $(($LINENUM + 2))p)
FILEPATH="$TMPDIR/$FILENAME"
ID=${FILENAME/.bam/}
BAMOUT="$OUTDIR/${ID}.${MIN}.pathseq.bam"
SCOREOUT="$OUTDIR/${ID}.${MIN}.scores.txt"
FILTERMETRICS="$OUTDIR/${ID}.${MIN}.filter_metrics.txt"
SCOREMETRICS="$OUTDIR/${ID}.${MIN}.scores_metrics.txt"
QCIN="$QCINDIR/${ID}.${MIN}.flagstats.txt"
QCOUT="$QCOUTDIR/${ID}.${MIN}.flagstats_out.txt"
echo "JobNum = $LINENUM"
echo "Memory = $SLURM_MEM_PER_NODE"
echo "CPUS per task = $SLURM_CPUS_PER_TASK"
echo "Token = $TOKENFILE"
echo "Manifest = $MANIFEST"
echo "minClippedReadLength = $MIN"
echo "Output dir = $OUTDIR"
echo "Temp. dir = $TMPDIR"
echo "QC in dir = $QCINDIR"
echo "QC out dir = $QCOUTDIR"
echo "Filepath = $FILEPATH"
echo "File size = $FILESIZE"
echo "UUID = $UUID"
if [ -f $BAMOUT ]; then
	echo "Output $BAMOUT already exists!"
	echo "EXITING"
	exit 0
else
	echo "Output $BAMOUT does not yet exist, continuing."
fi
if [ ! -f $FILEPATH ]; then
	echo "[ Downloading from TCGA ]"
	until $( curl -o $FILEPATH --remote-name --header "X-Auth-Token: $TOKEN" -C - "https://api.gdc.cancer.gov/data/$UUID" ); do
		printf '.'
		sleep 10
	done
else
	echo "Input BAM file already present, continuing"
fi
if [ ! -f $FILEPATH ]; then
	echo "$FILEPATH does not exist, aborting"
	exit 1
elif [ ! -s $FILEPATH ]; then
	echo "$FILEPATH is empty, aborting"
	rm $FILEPATH	
	exit 1
fi
FILESIZE="du -h $FILEPATH"
echo "File size = $FILESIZE"
echo "[ Checking that BAM is intact ]"
samtools quickcheck $FILEPATH; INTACT=$?
if [ $INTACT -eq 1 ]; then
	echo "$FILEPATH truncated, aborting."
	rm $FILEPATH
	exit 1
else
	echo "BAM file is good, continuing..."
fi
echo "[ Performing Flagstats QC on input BAM ]"
if [ ! -f $QCIN ]; then
	samtools flagstat $FILEPATH > $QCIN
fi
echo "[ Analyzing with Pathseq ]"
$GATK_HOME/gatk PathSeqPipelineSpark \
	--input $FILEPATH \
	--kmer-file $HOSTDIR/pathseq_host.bfi \
	--is-host-aligned true \
	--filter-bwa-image $HOSTDIR/pathseq_host.fa.img \
	--microbe-bwa-image $PATHDIR/pathseq_microbe.fa.img \
	--microbe-fasta $PATHDIR/pathseq_microbe.fa \
	--taxonomy-file $PATHDIR/pathseq_taxonomy.db \
	--min-clipped-read-length $MIN \
	--filter-metrics $FILTERMETRICS \
	--score-metrics $SCOREMETRICS \
	--scores-output $SCOREOUT \
	--output $BAMOUT \
	--TMP_DIR $BASEDIR/tmp_pathseq \
	--spark-master local[$SLURM_CPUS_PER_TASK]
echo "[ Pathseq has completed ]"
if [ ! -f $SCOREOUT ]; then
	echo "Pipeline failed:"
	echo "$SCOREOUT does not exist"
else
	# Check if pathseq output bam exists
	if [ ! -f $BAMOUT ]; then 
		echo "Pipeline failed:"
		echo "$SCOREOUT exists but $BAMOUT does not"
		rm $SCOREOUT
		rm -r $BAMOUT.parts
	else
		echo "SUCCESS!"
	fi
fi
echo "[ Performing flagstats QC on output bam ]"
if [ ! -f $QCOUT ]; then
        samtools flagstat $BAMOUT > $QCOUT
fi
echo "[ Deleting bam file ]"
rm $FILEPATH
echo "[ Pipeline complete ]"
