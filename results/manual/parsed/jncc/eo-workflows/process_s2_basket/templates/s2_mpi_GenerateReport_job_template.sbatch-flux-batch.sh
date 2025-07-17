#!/bin/bash
#FLUX: --job-name=lovable-hobbit-9297
#FLUX: --queue=short-serial
#FLUX: -t=21600
#FLUX: --urgency=16

/usr/bin/singularity exec --bind $reportMount:/report --bind $databaseMount:/database --bind $workingMount:/working --bind $stateMount:/state --bind $inputMount:/input --bind $staticMount:/static --bind $outputMount:/output $s2ArdContainer /app/exec.sh GenerateReport --dbFileName=s2ArdProcessing.db --reportFileName=$reportFileName --dem=$dem $arcsiReprojection --metadataConfigFile=$metadataConfigFile $metadataTemplate $arcsiCmdTemplate --oldFilenameDateThreshold=$oldFilenameDateThreshold --maxCogProcesses=$maxCogProcesses --removeInputFiles --local-scheduler
