#!/bin/bash
#FLUX: --job-name=muffled-snack-6189
#FLUX: --urgency=16

hostname
echo "Slurm job id:${SLURM_JOBID}:"
date
set -u  #       Error on usage of unset variables
set -o pipefail
if [ -n "$( declare -F module )" ] ; then
	echo "Loading required modules"
	module load CBI samtools/1.13 bowtie2/2.4.4 
	#bedtools2/2.30.0
fi
OUT="/francislab/data1/working/20220610-EV/20220614-preprocessing_with_umi/out"
mkdir -p ${OUT}
line=${SLURM_ARRAY_TASK_ID:-1}
echo "Running line :${line}:"
sample=$( sed -n "$line"p /francislab/data1/working/20220610-EV/20220614-preprocessing_with_umi/metadata.csv | awk -F, '{print $1}' )
r1=$( ls /francislab/data1/raw/20220610-EV/${sample}_*R1_001.fastq.gz )
echo $r1
if [ -z "${r1}" ] ; then
	echo "No line at :${line}:"
	exit
fi
date=$( date "+%Y%m%d%H%M%S" )
echo $r1
r2=${r1/_R1_/_R2_}
echo $r2
s=$( basename $r1 ) # SFHH009L_S7_L001_R1_001
s=${s%%_*}          # SFHH009L
b1=${s}.quality.R1.fastq.gz
b2=${s}.quality.R2.fastq.gz
echo $b1
echo $b2
outbase="${OUT}/${s}.quality"
f=${outbase}.R1.fastq.gz
if [ -f $f ] && [ ! -w $f ] ; then
	echo "Write-protected $f exists. Skipping."
else
	~/.local/bin/bbduk.bash in1=${r1} in2=${r2} out1=${outbase}.R1.fastq.gz out2=${outbase}.R2.fastq.gz minavgquality=15 threads=${SLURM_NTASKS:-auto}
	#	could also use this with cutadapt, although never tested ...
	#  -q [5'CUTOFF,]3'CUTOFF, --quality-cutoff [5'CUTOFF,]3'CUTOFF
	#                        Trim low-quality bases from 5' and/or 3' ends of each read before adapter
	#                        removal. Applied to both reads if data is paired. If one value is given, only
	#                        the 3' end is trimmed. If two comma-separated cutoffs are given, the 5' end is
	#                        trimmed with the first cutoff, the 3' end with the second.
	#
	#	Look into this? As some polyAs are salted with Gs. Is this for that?
	#  --nextseq-trim 3'CUTOFF
	#                        NextSeq-specific quality trimming (each read). Trims also dark cycles appearing
	#                        as high-quality G bases.
fi
inbase=${outbase}
outbase="${inbase}.consolidate"	#	"${OUT}/${s}.quality.format.consolidate"
f=${outbase}.R1.fastq.gz
if [ -f $f ] && [ ! -w $f ] ; then
	echo "Write-protected $f exists. Skipping."
else
	${PWD}/consolidate_umi.bash \
		18 \
		${inbase}.R1.fastq.gz \
		${inbase}.R2.fastq.gz \
		${outbase}.R1.fastq.gz \
		${outbase}.R2.fastq.gz
fi
inbase=${outbase}
outbase="${inbase}.range2-5000"	#	"${OUT}/${s}.quality.format.consolidate"
f=${outbase}.R1.fastq.gz
if [ -f $f ] && [ ! -w $f ] ; then
	echo "Write-protected $f exists. Skipping."
else
	${PWD}/consolidated_range.bash \
		2 5000 \
		${inbase}.R1.fastq.gz \
		${outbase}.R1.fastq.gz
fi
inbase=${outbase}
outbase="${inbase}.t1"	#	"${OUT}/${s}.quality.format.consolidate.t1"
f=${outbase}.R1.fastq.gz
if [ -f $f ] && [ ! -w $f ] ; then
	echo "Write-protected $f exists. Skipping."
else
	~/.local/bin/cutadapt.bash \
		--cores ${SLURM_NTASKS:-8} \
		--match-read-wildcards -n 4 \
		-a CTGTCTCTTATACACATCTC \
		-m 15 --trim-n \
		-o ${outbase}.R1.fastq.gz \
		${inbase}.R1.fastq.gz
fi
inbase=${outbase}
outbase="${outbase}.t3"
f=${outbase}.R1.fastq.gz
if [ -f $f ] && [ ! -w $f ] ; then
	echo "Write-protected $f exists. Skipping."
else
	~/.local/bin/cutadapt.bash \
		--cores ${SLURM_NTASKS:-8} \
		--match-read-wildcards -n 5 \
		--error-rate 0.20 \
		-a A{10} \
		-a A{150} \
		-m 15 --trim-n \
		-o ${outbase}.R1.fastq.gz \
		${inbase}.R1.fastq.gz
		#	NOTE that R2 is from TWO steps prior.
fi
exit
ll /francislab/data1/raw/20220610-EV/SF*R1_001.fastq.gz | wc -l
86
mkdir -p /francislab/data1/working/20220610-EV/20220614-preprocessing_with_umi/logs
date=$( date "+%Y%m%d%H%M%S" )
sbatch --mail-user=$(tail -1 ~/.forward)  --mail-type=FAIL --array=1-86%1 --job-name="preproc" --output="/francislab/data1/working/20220610-EV/20220614-preprocessing_with_umi/logs/preprocess.${date}-%A_%a.out" --time=1440 --nodes=1 --ntasks=8 --mem=60G /francislab/data1/working/20220610-EV/20220614-preprocessing_with_umi/array_wrapper.bash
date=$( date "+%Y%m%d%H%M%S" )
sbatch --mail-user=$(tail -1 ~/.forward)  --mail-type=FAIL --array=6,7,10,11%1 --job-name="preproc2" --output="/francislab/data1/working/20220610-EV/20220614-preprocessing_with_umi/logs/preprocess.${date}-%A_%a.out" --time=1440 --nodes=1 --ntasks=8 --mem=60G /francislab/data1/working/20220610-EV/20220614-preprocessing_with_umi/array_wrapper.bash
scontrol update ArrayTaskThrottle=6 JobId=352083
