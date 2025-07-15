#!/bin/bash
#FLUX: --job-name=bloated-toaster-3205
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load anaconda/2-4.1.1
source activate tf
gold="QALB.dev"  # make sure to drop the .gold or .m2 extension
case "$SLURM_ARRAY_TASK_ID" in
"1") config="p0 --initial_p_sample=0 --final_p_sample=0" ;;
"2") config="p1 --initial_p_sample=.1 --final_p_sample=.1" ;;
"3") config="p2 --initial_p_sample=.2 --final_p_sample=.2" ;;
"4") config="p3 --initial_p_sample=.3 --final_p_sample=.3" ;;
"5") config="p4 --initial_p_sample=.4 --final_p_sample=.4" ;;
"6") config="p5 --initial_p_sample=.5 --final_p_sample=.5" ;;
esac
save_dir=$(echo $config | cut -d' ' -f 1)
for i in `seq 5 5 30`; do
  # Training
  python3 -m ai.tests.qalb --max_epochs=$i --model_name=$config
  # Decoder
  python3 -m ai.tests.qalb --decode=ai/datasets/data/qalb/QALB.dev.mada.kmle --output_path=output/$save_dir/decoder_$i.out --model_name=$config
  # M2 scorer
  python2 ai/tests/m2scripts/m2scorer.py -v --beta 1 output/$save_dir/decoder_$i.out ai/datasets/data/qalb/$gold.m2 > output/$save_dir/m2scorer_$i.out
  # Full evaluations + readable output
  python3 analysis.py output/$save_dir/m2scorer.out > output/$save_dir/analysis_$i.out
done
