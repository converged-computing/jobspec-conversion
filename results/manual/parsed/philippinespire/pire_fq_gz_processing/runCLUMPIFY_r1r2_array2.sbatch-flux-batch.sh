#!/bin/bash
#FLUX: --job-name=clmp_r12
#FLUX: --exclusive
#FLUX: --priority=16

export SINGULARITY_BIND='/home/e1garcia'

enable_lmod
module load container_env pire_genome_assembly
export SINGULARITY_BIND=/home/e1garcia
FQPATTERN=${4}
TEMPDIR=${3}
INDIR=${1}
OUTDIR=${2}
THREADS=1   #clumpify uses a ton of ram, be conservative
GROUPS=auto   #controls how much ram is used, refer to manual
RAMPERTHREAD=${5}
ulimit -n 40960 
ulimit -a
mkdir -p $OUTDIR
all_samples=$(ls $INDIR/$FQPATTERN | \
	sed -e 's/r1\.fq\.gz//' -e 's/.*\///g')
all_samples=($all_samples)
sample_name=${all_samples[${SLURM_ARRAY_TASK_ID}]}
echo ${sample_name}
crun clumpify.sh \
	in=$INDIR/${sample_name}r1.fq.gz \
	in2=$INDIR/${sample_name}r2.fq.gz \
	out=$OUTDIR/${sample_name}clmp.r1.fq.gz \
	out2=$OUTDIR/${sample_name}clmp.r2.fq.gz \
	groups=$GROUPS \
	overwrite=t \
	usetmpdir=t \
	deletetemp=t \
	tmpdir=$TEMPDIR \
	dedupe=t \
	addcount=t \
	subs=2 \
	containment=t \
	consensus=f \
	-Xmx$RAMPERTHREAD
