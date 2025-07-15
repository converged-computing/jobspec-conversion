#!/bin/bash
#FLUX: --job-name=frigid-gato-3650
#FLUX: -t=3600
#FLUX: --priority=16

module load base/MATLAB
srun -n 1 --cpu_bind=no matlab -nodisplay -nosplash < /path/to/your/inputfile > /path/to/your/outputfile
