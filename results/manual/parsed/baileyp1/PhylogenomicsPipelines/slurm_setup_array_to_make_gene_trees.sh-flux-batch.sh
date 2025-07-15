#!/bin/bash
#FLUX: --job-name=stanky-chair-2977
#FLUX: --urgency=16

geneFile=$1
listFile=$2
fractnAlnCovrg=$3
pathToScripts=$4
phyloProgramDNA=$5
phyloProgramPROT=$6
fractnMaxColOcc=$7
cpuGeneTree=$8
alnParams="$9"
exePrefix="${10}"
alnProgram="${11}"
dnaSelected="${12}"
proteinSelected="${13}"
codonSelected="${14}"
filterSeqs1="${15}"
maxColOccThreshold="${16}"
filterSeqs2="${17}"
trimAln1="${18}"
trimAln2="${19}"
treeshrink="${20}"
outgroupRoot="${21}"
checkpointing="${22}"
echo Inside Slurm array script, listFile: $listFile
echo Inside Slurm array script, fractnAlnCovrge: $fractnAlnCovrg
echo "SLURM_JOB_ID: " $SLURM_JOB_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
echo "SLURM_ARRAY_TASK_COUNT: " $SLURM_ARRAY_TASK_COUNT
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID		# Should be a different value reported in each eio_pipeline-%a.out file
echo
mapfile -t SAMPLELIST < $listFile
echo GeneId: ${SAMPLELIST[$SLURM_ARRAY_TASK_ID]}
echo
exePrefix="/usr/bin/time -v "		# this time command gets the RSS memory
$exePrefix $pathToScripts/make_gene_trees.sh \
${SAMPLELIST[$SLURM_ARRAY_TASK_ID]} \
$geneFile \
$fractnAlnCovrg \
$phyloProgramDNA \
$phyloProgramPROT \
$fractnMaxColOcc \
$cpuGeneTree \
"$alnParams" \
"$exePrefix" \
"$alnProgram" \
$dnaSelected \
$proteinSelected \
$codonSelected \
"$filterSeqs1" \
$pathToScripts \
$maxColOccThreshold \
"$filterSeqs2" \
"$trimAln1" \
"$trimAln2" \
"$treeshrink" \
"$outgroupRoot" \
"$checkpointing"
