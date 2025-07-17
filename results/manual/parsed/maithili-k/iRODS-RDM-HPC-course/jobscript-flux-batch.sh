#!/bin/bash
#FLUX: --job-name=outstanding-leopard-0481
#FLUX: --queue=short
#FLUX: -t=240
#FLUX: --urgency=16

cd $HOME/iRODS-RDM-HPC-course
rodscoll='/surfZone1/home/irods-user1/YOUR OUTPUT COLLECTION'
inputdir="$TMPDIR/inputdat$SLURM_JOBID"
outputdir="$TMPDIR/outputdat$SLURM_JOBID"
mkdir $inputdir
mkdir $outputdir
iquest "%s/%s" "select COLL_NAME, DATA_NAME where META_DATA_ATTR_NAME = 'author' and META_DATA_ATTR_VALUE = 'Lewis Carroll'" | parallel iget {} $inputdir
resultsfile=results$SLURM_JOBID.dat
cat $inputdir/* | tr '[:upper:]' '[:lower:]' | awk '{for(i=1;i<=NF;i++) count[$i]++} END {for(j in count) print j, count[j]}' > $outputdir/$resultsfile
iput $outputdir/$resultsfile $rodscoll
imeta add -d $rodscoll/$resultsfile 'somekey' 'somevalue'
imeta ls -d $rodscoll/$resultsfile
