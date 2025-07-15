#!/bin/bash
#FLUX: --job-name=arid-caramel-5789
#FLUX: --queue=hbfraser
#FLUX: -t=32400
#FLUX: --urgency=16

module load fraserconda
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/mappingMutationCalling_pipeline/
date
echo -e "Starting fastq prep\n"
snakemake --snakefile SnakefileFastqPrep.smk --max-jobs-per-second 3 --max-status-checks-per-second 0.016 --nolock --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
if [ $? != 0 ]
then
    echo -e "ERROR something went wrong with fastq prep\n"
    exit 1
fi
date
echo -e "Fastq prep Snakemake done!\n\n"
date
echo -e "Starting Pileups snakemake\n"
    snakemake --snakefile SnakefilePileup.smk --printshellcmds --keep-going --max-jobs-per-second 3 --max-status-checks-per-second 0.016 --nolock --restart-times 2 --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
    #snakemake --snakefile SnakefilePileup.smk --printshellcmds --max-jobs-per-second 3 --max-status-checks-per-second 0.016 --nolock --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
date
echo -e "Create pileups Snakemake done!\n\n"
