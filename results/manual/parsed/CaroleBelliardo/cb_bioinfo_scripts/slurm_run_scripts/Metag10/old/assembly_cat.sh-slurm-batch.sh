#!/bin/bash
#FLUX: --job-name=mg
#FLUX: -c=70
#FLUX: --queue=infinity
#FLUX: --urgency=16

module load singularity/3.5.3
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
SING2='singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'
cd '/lerins/hub/projects/25_IPN_Metag/10Metag/0-cat/'
FILENAME='cat_10metag.fasta'
hismR='hifiasm3'
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/pb-metagToolkit2.sif'
SING2='singularity exec  --bind /work/cbelliardo:/work/cbelliardo  --bind /lerins/hub:/lerins/hub'
FILENAME=hifiasm3.p_ctg.gfa
cd /lerins/hub/projects/25_IPN_Metag/HiFi-MAG-Pipeline_pacbio/HiFi-MAG-Pipeline_cat
$SING2 $SING_IMG /home/tools/conda/bin/snakemake --snakefile Snakefile-hifimags --configfile configs/Sample-Config.yaml -j 70 --use-conda #--conda-frontend conda
