#!/bin/bash
#FLUX: --job-name=wgs-msweep-k-qva-strain-bins
#FLUX: -t=28799
#FLUX: --urgency=16

export LC_ALL='C'
export LANG='C'

export LC_ALL="C"
export LANG="C"
module load CMake GCC
nprocs=1
nthreads=1
species="K_qva"
basedir=$WRKDIR/wgs-msweep
info=$(sed -n "${SLURM_ARRAY_TASK_ID} p" $basedir/out/$species""_bins.txt)
accession=$(echo $info | grep -o "ERR[0-9]*")
bin=$basedir/out/mGEMS/$info
fwd=$basedir/out/mGEMS/$accession/$species/$species""_1.fastq.gz
rev=$basedir/out/mGEMS/$accession/$species/$species""_2.fastq.gz
fwdaln=$basedir/out/themisto/$accession/$species""_1.aln
revaln=$basedir/out/themisto/$accession/$species""_2.aln
fwdaln=$fwdaln"".gz
revaln=$revaln"".gz
outdir=$basedir/out/mGEMS/$accession/$species
probs=$basedir/out/mSWEEP/$accession/$species""_probs.csv.xz
abundances=$basedir/out/mSWEEP/$accession/$species""_abundances.txt
index=$basedir/reference/themisto-old-index-autocolors
$USERAPPL/mGEMS/build/bin/mGEMS bin --min-abundance 0.000001 --themisto-alns $fwdaln,$revaln -o $outdir --probs $probs -a $abundances --index $index
xz --extreme $outdir/*.bin
