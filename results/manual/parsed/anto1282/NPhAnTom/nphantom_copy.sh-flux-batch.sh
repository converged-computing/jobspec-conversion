#!/bin/bash
#FLUX: --job-name=NPhAnToM_%j
#FLUX: -c=2
#FLUX: -t=36000
#FLUX: --urgency=16

export SINGULARITY_LOCALCACHEDIR='/maps/projects/mjolnir1/people/${USER}/SingularityTMP'
export SINGULARITY_TMPDIR='/maps/projects/mjolnir1/people/${USER}/SingulquarityTMP'
export NXF_CLUSTER_SEED='$(shuf -i 0-16777216 -n 1)'
export NXF_CONDA_ENABLED='true'

while [[ $# -gt 0 ]]; do
  case $1 in
    --SRR)
      SRRNUMBER="--IDS $2"
      shift # past argument
      shift # past value
      ;;
    --tower)
      TOWERTOKEN="$2"
      shift 
      shift 
      ;;
    --profile)
      PROFILE="$2"
      shift
      shift
      ;;
    --minlength)
      MINLENGTH="$2"
      shift
      shift
      ;;
    --contigs)
      CONTIGS="$2"
      shift
      shift
      ;;
    --resume)
      RESUME=-resume
      shift
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done
if [ ${minlength} < 1000 ]
then 
  echo minlength must be more than 1000, exiting
  exit 1
fi
if [ ${CONTIGS} == "c" ]
then
  CONTIGS="contigs"
elif [ ${CONTIGS} == "s" ]
then
  CONTIGS="scaffolds"
else
  CONTIGS="contigs"
fi
echo ${SRRNUMBER} ${PROFILE} 
export SINGULARITY_LOCALCACHEDIR="/maps/projects/mjolnir1/people/${USER}/SingularityTMP"
export SINGULARITY_TMPDIR="/maps/projects/mjolnir1/people/${USER}/SingulquarityTMP"
export NXF_CLUSTER_SEED=$(shuf -i 0-16777216 -n 1)
export NXF_CONDA_ENABLED=true
module purge
module load openjdk/11.0.0
module load singularity/3.8.0 nextflow miniconda/4.11.0
srun nextflow run NPhAnToM.nf --IDS ${SRRNUMBER} -profile ${PROFILE} ${RESUME} -with-mpi -with-tower --accessToken ${TOWERTOKEN} --minLength ${MINLENGTH} --contigs ${CONTIGS}
