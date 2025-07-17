#!/bin/bash
#FLUX: --job-name=mg
#FLUX: -c=60
#FLUX: --queue=treed
#FLUX: --urgency=16

module load singularity/3.5.3
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
SING2='singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'
fastaR='/lerins/hub/projects/25_IPN_Metag/10Metag/fasta' 
cd $fastaR
FILES=($(ls -1 *.fasta))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
PREFS=($(ls -1 *.fasta | cut -f1 -d'.'))
PREF=${FILES[$SLURM_ARRAY_TASK_ID]}
db_kraken='/lerins/hub/DB/RefSeq_genomic/RefSeq_genomic_kraken'
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools3.8.sif'
out='/lerins/hub/projects/25_IPN_Metag/10Metag/kraken_reads'
$SING2 $SING_IMG /home/tools/kraken/kraken2 --confidence 0.1 --threads 60 --db $db_kraken $FILENAME --output ${out}/${PREF}0.1.krak
