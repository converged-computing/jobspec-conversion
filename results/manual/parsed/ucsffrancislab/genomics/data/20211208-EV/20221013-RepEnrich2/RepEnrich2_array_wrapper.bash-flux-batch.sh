#!/bin/bash
#FLUX: --job-name=lovely-poo-5080
#FLUX: --priority=16

hostname
echo "Slurm job id:${SLURM_JOBID}:"
date
set -u  #       Error on usage of unset variables
set -o pipefail
if [ -n "$( declare -F module )" ] ; then
	echo "Loading required modules"
	#module load CBI samtools/1.13 bowtie2/2.4.4 
	#bedtools2/2.30.0
fi
set -x  #       print expanded command before executing it
SUFFIX="quality.format.t1.t3.notphiX.notviral.hg38.bam"
IN="/francislab/data1/working/20211208-EV/20211208-preprocessing/out_noumi"
OUT="/francislab/data1/working/20211208-EV/20221013-RepEnrich2/out"
mkdir -p ${OUT}
line=${SLURM_ARRAY_TASK_ID:-1}
echo "Running line :${line}:"
bam=$( ls -1 ${IN}/*.${SUFFIX} | sed -n "$line"p )
echo $bam
if [ -z "${bam}" ] ; then
	echo "No line at :${line}:"
	exit
fi
date=$( date "+%Y%m%d%H%M%S%N" )
trap "{ chmod -R a+w $TMPDIR ; }" EXIT
base=$( basename ${bam} .${SUFFIX} )
out_base=${OUT}/${base}
f=${out_base}_multimap_R1.fastq
if [ -f $f ] && [ ! -w $f ] ; then
	echo "Write-protected $f exists. Skipping."
else
	singularity exec --bind /francislab,/scratch /francislab/data1/refs/singularity/RepEnrich2.img \
		python /RepEnrich2/RepEnrich2_subset.py ${bam} 20 ${out_base} --pairedend TRUE
	#	Not all exist. This is for paired and not paired
	chmod -w ${out_base}_unique.bam
	chmod -w ${out_base}_multimap_filtered.bam
	chmod -w ${out_base}_map.bam
	chmod -w ${out_base}_multimap.fastq
	chmod -w ${out_base}_multimap_R1.fastq
	chmod -w ${out_base}_multimap_R2.fastq
fi
f=${out_base}/${base}_fraction_counts.txt
if [ -f $f ] && [ ! -w $f ] ; then
	echo "Write-protected $f exists. Skipping."
else
	echo "Step 4) Run RepEnrich2 on the data"
	#	This creates folders pair1_ and sorted_ so it must be isolate from other runs in its own dir
	singularity exec --bind /francislab,/scratch /francislab/data1/refs/singularity/RepEnrich2.img \
		python /RepEnrich2/RepEnrich2.py /francislab/data1/refs/RepEnrich2/hg38_repeatmasker_clean.txt \
			${out_base} ${base} \
			/francislab/data1/refs/RepEnrich2/setup_folder_hg38 \
			${out_base}_multimap_R1.fastq \
			${out_base}_unique.bam \
			--pairedend TRUE --fastqfile2 ${out_base}_multimap_R2.fastq \
			--cpus ${SLURM_NTASKS:-8}
	chmod -w ${out_base}/${base}_class_fraction_counts.txt
	chmod -w ${out_base}/${base}_fraction_counts.txt
	chmod -w ${out_base}/${base}_family_fraction_counts.txt
fi
echo "Done"
date
exit
ll /francislab/data1/working/20211208-EV/20211208-preprocessing/out_noumi/*quality.format.t1.t3.notphiX.notviral.hg38.bam | wc -l
13
mkdir -p ${PWD}/logs
date=$( date "+%Y%m%d%H%M%S%N" )
sbatch --mail-user=$(tail -1 ~/.forward)  --mail-type=FAIL --array=1-13%1 --job-name="RepEnrich2" --output="${PWD}/logs/RepEnrich2.${date}-%A_%a.out" --time=4320 --nodes=1 --ntasks=8 --mem=60G --gres=scratch:250G ${PWD}/RepEnrich2_array_wrapper.bash
scontrol update ArrayTaskThrottle=6 JobId=352083
