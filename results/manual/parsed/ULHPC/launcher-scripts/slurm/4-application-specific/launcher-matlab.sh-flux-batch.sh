#!/bin/bash
#FLUX: --job-name=SingleNodeParallelJob
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

module load base/MATLAB
srun -n 1 --cpu_bind=no matlab -nodisplay -nosplash < /path/to/your/inputfile > /path/to/your/outputfile
