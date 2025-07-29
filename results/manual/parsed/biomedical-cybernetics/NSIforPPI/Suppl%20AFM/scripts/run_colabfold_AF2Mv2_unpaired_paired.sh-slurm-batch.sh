#!/bin/bash
#FLUX: --job-name=ColabFold
#FLUX: -c=8
#FLUX: --queue=alpha
#FLUX: -t=86400
#FLUX: --urgency=16

export PATH='/lustre/ssd/ws/iabdelha-IA-AF-SSD-workspace/alphafold/data/colabfold_batch/bin:$PATH'

module load modenv/hiera GCC/10.2.0 CUDA/11.3.1 OpenMPI/4.0.5
name='run_colabfold_AF2Mv2_unpaired_paired.sh'
maxsim=120
sleeptime=120
if [ "$#" -eq 0 ]
then
  sim=1
else
  sleep $sleeptime
  sim=$(($1+1))
fi
if [ $sim -lt $maxsim ]; then
  echo sbatch $name $sim
  sbatch $name $sim
fi
array_positive=($(ls /lustre/ssd/ws/iabdelha-IA-AF-SSD-workspace/alphafold/data/alphafold_singularity/FASTA_files/Yeast/Positive_set))
array_negative=($(ls /lustre/ssd/ws/iabdelha-IA-AF-SSD-workspace/alphafold/data/alphafold_singularity/FASTA_files/Yeast/Negative_set))
sorted_positive=($(printf '%s\n' "${array_positive[@]}" | sort -n))
sorted_negative=($(printf '%s\n' "${array_negative[@]}" | sort -n))
TEMPPATH=/lustre/ssd/ws/iabdelha-IA-AF-SSD-workspace/alphafold/data/alphafold_singularity/TEMP_AlphaFold2-multimer-v2_unpaired+paired
for (( i=0; i<${#sorted_negative[*]}; ++i));
do
  if [[ ! -f "$TEMPPATH/${sorted_negative[$i]}.TEMP" ]];
  then
    if [[ ${sorted_negative[$i]} ]];
    then
      PAIR_TO_TEST=${sorted_negative[$i]}
      SEQUENCE_FILE=/lustre/ssd/ws/iabdelha-IA-AF-SSD-workspace/alphafold/data/alphafold_singularity/FASTA_files/Yeast/Negative_set/
      COLABFOLD_OUTPUT=/lustre/ssd/ws/iabdelha-IA-AF-SSD-workspace/alphafold/alphafold_output/Yeast/Negative_set/AlphaFold2-multimer-v2/unpaired+paired/
      touch $TEMPPATH/${sorted_negative[$i]}.TEMP
      break
    fi
  elif [[ ! -f "$TEMPPATH/${sorted_positive[$i]}.TEMP" ]];
  then
    if [[ ${sorted_positive[$i]} ]];
    then
      PAIR_TO_TEST=${sorted_positive[$i]}
      SEQUENCE_FILE=/lustre/ssd/ws/iabdelha-IA-AF-SSD-workspace/alphafold/data/alphafold_singularity/FASTA_files/Yeast/Positive_set/
      COLABFOLD_OUTPUT=/lustre/ssd/ws/iabdelha-IA-AF-SSD-workspace/alphafold/alphafold_output/Yeast/Positive_set/AlphaFold2-multimer-v2/unpaired+paired/
      touch $TEMPPATH/${sorted_positive[$i]}.TEMP
      break
    else
      continue
    fi
  else
    continue
  fi
done
cd /lustre/ssd/ws/iabdelha-IA-AF-SSD-workspace/alphafold/data/colabfold_batch/bin
export PATH="/lustre/ssd/ws/iabdelha-IA-AF-SSD-workspace/alphafold/data/colabfold_batch/bin:$PATH"
echo $SEQUENCE_FILE$PAIR_TO_TEST
colabfold_batch --num-recycle 3 --templates --pair-mode unpaired+paired --model-type AlphaFold2-multimer-v2 --rank intscore $SEQUENCE_FILE$PAIR_TO_TEST $COLABFOLD_OUTPUT$PAIR_TO_TEST
cd $COLABFOLD_OUTPUT$PAIR_TO_TEST
shopt -s extglob
rm -r !(*.pdb|*.png|config.json|timings.json|stats_*.json)
