#!/bin/bash
#FLUX: --job-name=carnivorous-pot-5632
#FLUX: --urgency=16

module load gcc/5.3.0
module load perl/5.18.4-threads
module load java/jdk8u73
module load samtools/1.3
module load bowtie2/2.2.7
module load trinity/2.4.0
/bin/hostname
set -x
ulimit -s unlimited
ulimit -c unlimited
ulimit -a
SCR=$LOCAL
jobid=$SLURM_JOBID
arrayid=$SLURM_ARRAY_JOB_ID
arraytask=$SLURM_ARRAY_TASK_ID
node=`/bin/hostname`
dataset=GF
fs=local
version=2.3.2_icc-16.03_gcc-5.3
name=trinity.$dataset.$node.$fs.$version.$jobid.${arrayid}_${arraytask}
ncores=80
nthreads=80
maxmem=2800G
nthreads_bfly=20
bflymaxheap=32G
bflyinitheap=1G
nthreads_gc=2
submitdir=$SLURM_SUBMIT_DIR
left_reads="${SAMPLE}.all.left.fastq.gz"
right_reads="${SAMPLE}.all.right.fastq.gz"
rundir_dest=/pylon2/oc4s88p/groussma/diel1_assembly
mkdir -p $rundir_dest
rundir=$SCR/$name
mkdir -p $rundir
datadir_src=/pylon5/oc4s88p/groussma/diel1_reads/
datadir=$SCR
cd $rundir
time cp $datadir_src/$left_reads $rundir
time cp $datadir_src/$right_reads $rundir
time srun Trinity --seqType fq --max_memory $maxmem \
--left $left_reads --right $right_reads --min_contig_length 300 --CPU $nthreads \
--min_kmer_cov 2 --normalize_reads --SS_lib_type RF \
--bflyCPU $nthreads_bfly --bflyGCThreads $nthreads_gc --bflyHeapSpaceMax $bflymaxheap --bflyHeapSpaceInit $bflyinitheap \
--output $rundir/trinity_out_dir >& $submitdir/$name.ncor_${ncores}.nthr_${nthreads}.maxmem_${maxmem}.bflythr_${nthreads_bfly}.bflygc_${nthreads_gc}.bflymh_${bflymaxheap}_bflyih_${bflyinitheap}.out
if [[ $rundir == $SCR/$name ]]; then
    mkdir -p $rundir_dest/$jobid
    time cp -p $SCR/$name/trinity_out_dir/Trinity* $rundir_dest/$jobid
fi
