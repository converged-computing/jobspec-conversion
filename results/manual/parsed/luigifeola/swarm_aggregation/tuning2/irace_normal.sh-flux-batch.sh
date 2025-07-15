#!/bin/bash
#FLUX: --job-name=irace_tuning2_10
#FLUX: --queue=long
#FLUX: -t=864000
#FLUX: --priority=16

module load releases/2020b
module load Python/3.8.6-GCCcore-10.2.0
module load R
srun /opt/cecisw/arch/easybuild/2020b/software/R/4.0.4-foss-2020b/lib64/R/library/irace/bin/irace --exec-dir=/home/unamur/fac_info/asion/swarm_aggregation/tuning2 --scenario scenario.txt
