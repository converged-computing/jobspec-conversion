#!/bin/bash
#SBATCH --account=defra_eo_jncc_s2_ard
#SBATCH --output=$jobWorkingDir/%J_GenerateReport.out
#SBATCH --error=$jobWorkingDir/%J_GenerateReport.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --chdir=$jobWorkingDir
#SBATCH --dependency=$upstreamJobId

/usr/bin/singularity exec --bind $reportMount:/report --bind $databaseMount:/database --bind $workingMount:/working --bind $stateMount:/state --bind $inputMount:/input --bind $staticMount:/static --bind $outputMount:/output $s2ArdContainer /app/exec.sh GenerateReport --dbFileName=s2ArdProcessing.db --reportFileName=$reportFileName --dem=$dem $arcsiReprojection --metadataConfigFile=$metadataConfigFile $metadataTemplate $arcsiCmdTemplate --maxCogProcesses=$maxCogProcesses --removeInputFiles --local-scheduler
