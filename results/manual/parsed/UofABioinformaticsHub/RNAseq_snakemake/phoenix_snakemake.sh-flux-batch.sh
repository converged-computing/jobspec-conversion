#!/bin/bash
#FLUX: --job-name=rainbow-cat-0779
#FLUX: -t=7200
#FLUX: --urgency=16

module load Python/3.6.1-foss-2016b
module load AdapterRemoval/2.2.1-foss-2016b
module load fastqc/0.11.4
module load Subread/1.5.2-foss-2016b
module load StringTie/1.3.3-foss-2017a
module load Salmon/0.8.2
module load STAR/2.5.3a-foss-2016b
module load sambamba/0.6.6-foss-2016b
module load picard/2.2.4-Java-1.8.0_121
module load kallisto/0.43.1-foss-2017a
module load SAMtools/1.3.1-foss-2016b
source /path/to/python/virtal/environment/bin/activate 
	## I.e. if you re-run this script due to an error. 
snakemake -R --cores 16 -s /path/to/snakefile.py
deactivate 
