#!/bin/bash
#FLUX: --job-name=pusheena-bits-2537
#FLUX: --queue=preemptable_q
#FLUX: -t=7200
#FLUX: --urgency=16

export qcSoft='/projects/nmayhall_lab/qchem5'
export QCPATH='$qcSoft/qchem.librassf-bloch-dev/'
export QC='$qcSoft/qchem.librassf-bloch-dev/'
export QCAUX='/projects/nmayhall_lab/qchem5/qcaux/'
export QCSCRATCH='$HOME/tinkercliff_qchem'
export PATH='$PATH:$QC/bin:$QC/bin/perl'
export OUT='${FILE%%.*}.out'
export DIR='${FILE%%.*}'

module reset
module load CMake/3.16.4-intel-2019b
module load intel/2019b imkl/2019.5.281-iimpi-2019b
export qcSoft="/projects/nmayhall_lab/qchem5"
export QCPATH="$qcSoft/qchem.librassf-bloch-dev/"
export QC=$qcSoft/qchem.librassf-bloch-dev/
export QCAUX="/projects/nmayhall_lab/qchem5/qcaux/"
export QCSCRATCH="$HOME/tinkercliff_qchem"
export PATH=$PATH:$QC/bin:$QC/bin/perl
FILE=$1
export OUT=${FILE%%.*}.out
export DIR=${FILE%%.*}
qchem -nt 24 $FILE $OUT
exit;
