#!/bin/bash
#FLUX: --job-name=tracerConda
#FLUX: -t=86401
#FLUX: --urgency=16

date
module load anaconda
source activate tracer_teichlab_2018-03-08
cd /srv/gsfs0/projects/brunet/Buckley/5.BenNSCProject/2.Tcell/
tracer assemble -c 5.Tracer/CONFIG \
				0.Raw/${F}_R1_001.fastq \
				0.Raw/${F}_R2_001.fastq \
				$F \
				5.Tracer/Output_Conda_Mar15 
date
echo "Finished"
