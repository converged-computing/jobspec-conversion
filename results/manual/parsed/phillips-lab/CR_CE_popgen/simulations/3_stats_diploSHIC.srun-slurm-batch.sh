#!/bin/bash
#SBATCH --job-name=12stats
#SBATCH --account=phillipslab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=8-08:00:00
#SBATCH --array=0-4999%100

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
diploSHIC="/projects/phillipslab/ateterina/scripts/diploSHIC/diploSHIC.py"
diploSHICN="/projects/phillipslab/ateterina/scripts/diploSHIC/diploSHIC_NORMALIZATION.py"
dir="/projects/phillipslab/ateterina/slim/worms_snakemake"
for simdir in sim30rep sim70rep simmut15 neutral_extra balancing;do
  cd $dir/$simdir
  listfiles=(d*/*vcf)
  name=${listfiles[$SLURM_ARRAY_TASK_ID]}
  filename=(${name//\// })
  echo $filename
  cd ${filename[0]}
  file=${filename[1]}
  python $diploSHIC fvecVcf --winSize 40000  --numSubWins 1 diploid $file 1 3000000 ${file/vcf/12stats.txt}
  python $diploSHICN fvecVcf --winSize 1000000  --numSubWins 25 diploid $file 1 3000000 ${file/vcf/12stats_1mb_25.txt}
  grep -P "win|-1000000|-2000000|-3000000" ${file/vcf/12stats_1mb_25.txt} >${file/vcf/12stats_1mb_25_short.txt}
done
for simdir in decay decay_balancing exponent fluctuations;do
  cd $dir/$simdir
  listfiles=(d*/*vcf)
  name=${listfiles[$SLURM_ARRAY_TASK_ID]}
  filename=(${name//\// })
  echo $filename
  cd ${filename[0]}
  file=${filename[1]}
  python $diploSHIC fvecVcf --winSize 100000  --numSubWins 1 diploid $file 1 3000000 ${file/vcf/12stats.txt}
done
