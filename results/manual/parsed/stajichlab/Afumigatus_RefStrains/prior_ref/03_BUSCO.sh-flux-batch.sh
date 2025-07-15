#!/bin/bash
#FLUX: --job-name=fugly-poodle-8171
#FLUX: -n=8
#FLUX: --urgency=16

export AUGUSTUS_CONFIG_PATH='$(realpath lib/augustus/3.3/config)'

module unload miniconda3
module load busco
export AUGUSTUS_CONFIG_PATH=$(realpath lib/augustus/3.3/config)
module load workspace/scratch
CPU=${SLURM_CPUS_ON_NODE}
N=${SLURM_ARRAY_TASK_ID}
if [ ! $CPU ]; then
     CPU=2
fi
if [ ! $N ]; then
    N=$1
    if [ ! $N ]; then
        echo "Need an array id or cmdline val for the job"
        exit
    fi
fi
GENOMEFOLDER=genomes
EXT=fasta
LINEAGE=eurotiomycetes_odb10
OUTFOLDER=BUSCO
SEED_SPECIES=anidulans
GENOMEFILE=$(ls $GENOMEFOLDER/*.${EXT} | sed -n ${N}p)
echo "GENOMEFILE is $GENOMEFILE"
NAME=$(basename $GENOMEFILE .$EXT)
GENOMEFILE=$(realpath $GENOMEFILE)
if [ -d "$OUTFOLDER/${NAME}" ];  then
    echo "Already have run $NAME in folder busco - do you need to delete it to rerun?"
    exit
else
  busco -m genome -l $LINEAGE -c $CPU -o ${NAME} --out_path ${OUTFOLDER} --offline --augustus_species $SEED_SPECIES \
	  --in $GENOMEFILE --download_path $BUSCO_LINEAGES
fi
