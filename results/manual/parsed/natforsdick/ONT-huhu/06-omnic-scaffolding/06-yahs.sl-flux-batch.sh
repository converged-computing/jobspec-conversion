#!/bin/bash
#FLUX: --job-name=huhu-yahs
#FLUX: -c=2
#FLUX: -t=5400
#FLUX: --urgency=16

REF_DIR='/nesi/nobackup/ga03186/Huhu_MinION/combined-trimmed-data/omnic-scaffolding/shasta-purged-polished-omnic/'
REF='medaka-consensus.fa'
echo “Making FAI from reference assembly”
cd $REF_DIR
if [ ! -e ${REF_DIR}${REF}.fai ]; then
	echo "indexing ${REF_DIR}${REF}"
	module purge
	module load SAMtools/1.10-GCC-9.2.0
	samtools faidx ${REF_DIR}${REF}
	echo  "indexed"
	date
	ml purge
fi
YAHS='/nesi/project/ga03186/scripts/Hi-C_scripts/yahs/yahs'
IN_DIR='/nesi/nobackup/ga03186/Huhu_MinION/combined-trimmed-data/omnic-scaffolding/shasta-purged-polished-omnic/'
IN_BAM='medaka-consensus-mapped.PT.bam'
OUT_DIR='/nesi/nobackup/ga03186/Huhu_MinION/combined-trimmed-data/omnic-scaffolding/shasta-purged-polished-omnic/yahs/'
if [ ! -e ${OUT_DIR} ]; then
	mkdir -p ${OUT_DIR}
else
	echo "Found ${OUT_DIR}"
fi
cd ${OUT_DIR}
echo "Starting YAHS for ${IN_BAM} to scaffold ${REF}"
date
$YAHS ${REF_DIR}${REF} ${IN_DIR}${IN_BAM} -o huhu-medaka-mapped-NMC --no-mem-check
echo "Completed YAHS scaffolding"
date
