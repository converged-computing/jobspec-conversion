#!/bin/bash
#FLUX: --job-name=literatureTestSuiteAnalysis
#FLUX: --queue=snowy
#FLUX: -t=86400
#FLUX: --urgency=16

module load gcccore/10.2.0
module load cmake/3.18.4
module load eigen/3.3.8
cd ../cpp_code
./main litSuiteTesting ${SLURM_ARRAY_TASK_ID}
