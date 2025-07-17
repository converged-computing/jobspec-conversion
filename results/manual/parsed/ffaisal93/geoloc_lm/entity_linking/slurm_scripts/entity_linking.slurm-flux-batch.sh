#!/bin/bash
#FLUX: --job-name=mbert_acl
#FLUX: --queue=all-HiPri
#FLUX: -t=715
#FLUX: --urgency=16

                      #   bigmem-LoPri, bigmem-HiPri, gpuq, CS_q, CDS_q, ...
source ~/fairseq/bin/activate
module load cuda/10.0
cd ../GENRE
dirr="../data/geoloc"
outdir="../data/geoloc"
mode=$1
label='CONSTRUCT_MLING'
filep=$2
for dir in $dirr/*
do
  echo dir: ${dir}
  if [ "$dir" != '${dirr}/**DS_Store**' ] && [ "$dir" != '${dirr}/._**' ] && [ "$dir" == "${dirr}/${filep}" ]; then
      dir=${dir}/${mode}/entity
      for file in ${dir}/*
      do
          if [ "$file" != '${dir}/**DS_Store**' ] && [ "$file" != '${dir}/._**' ]; then
              echo file: $file
              base=$(basename $file .pickle)
              echo base: $base
              # echo ../tr_output/${label}_${base}.err
              echo ${mode} ${base} ${file} ${outdir}
              echo ${mode} ${base} ${file} ${outdir} >> jobs.txt
              # sbatch -o ../tr_output/${label}_${base}.out -e ../tr_output/${label}_${base}.err entity_linking.slurm $file $base $outdir $mode
              python entity_linking.py --mode ${mode} \
                --name ${base} \
                --data_file ${file} \
                --out_dir ${outdir}
          fi
      done
  fi
done
