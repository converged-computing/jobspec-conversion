#!/bin/bash
#FLUX: --job-name=tart-banana-5151
#FLUX: -t=86400
#FLUX: --urgency=16

module load CCEnv StdEnv/2020 java/17.0.2
commit_message=$(git log -1 --pretty=format:"%s" | sed 's/ /_/g')
java -Xmx150G -jar gym-fs-fat-1.0-SNAPSHOT.jar 2>&1 | tee /scratch/b/bengioy/breandan/log_${commit_message}.txt
