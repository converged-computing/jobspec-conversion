#!/bin/bash
#FLUX: --job-name=ExampleBatchScript
#FLUX: --queue=thsu
#FLUX: -t=604800
#FLUX: --urgency=16

	vpkg_require matlab
	vpkg_require openmpi
. /opt/shared/slurm/templates/libexec/openmpi.sh
	echo "Hello World!"
