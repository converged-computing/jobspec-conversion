#!/bin/bash
#FLUX: --job-name=eval_$dir$sffx_$data
#FLUX: -c=8
#FLUX: --queue=jag-hi
#FLUX: --urgency=16

dir="$1"
sffx="$2"
data=${3:-'imagenet256'} # should be imagenet256 or imagenet_100
model=${4:-'resnet'} # should be resnet or convnextS
mkdir -p "$dir"/eval_logs
echo "Evaluating " "$dir" "$sffx" on  "$data"
feature_dir=/scr/biggest/yanndubs/"$dir"/"$data"/features
sbatch <<EOT
source ~/.zshrc_nojuice
echo \$(which -p conda)
echo "Feature directory : $feature_dir"
end_featurized="$feature_dir/is_featurized"
echo "featurizing."
conda activate vissl
bin/extract_features_sphinx.sh "$dir" "$sffx" "$data" "$model"
touch "\$end_featurized"
echo "Linear eval."
conda activate probing
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-5_l01_b2048 --weight-decay 1e-5 --lr 0.1 --batch-size 2048 --is-no-progress-bar --is-monitor-test
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-6_l01_b2048 --weight-decay 1e-6 --lr 0.1 --batch-size 2048 --is-no-progress-bar --is-monitor-test
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w3e-6_l01_b2048 --weight-decay 3e-6 --lr 0.1 --batch-size 2048 --is-no-progress-bar --is-monitor-test
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-6_l03_b2048 --weight-decay 1e-6 --lr 0.3 --batch-size 2048 --is-no-progress-bar --is-monitor-test
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-6_l003_b2048 --weight-decay 1e-6 --lr 0.03 --batch-size 2048 --is-no-progress-bar --is-monitor-test
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-6_l001_b2048 --weight-decay 1e-6 --lr 0.01 --batch-size 2048 --is-no-progress-bar --is-monitor-test
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-6_l0003_b2048 --weight-decay 1e-6 --lr 0.003 --batch-size 2048 --is-no-progress-bar --is-monitor-test
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-6_l01_bn_2048 --weight-decay 1e-6 --lr 0.1 --is-batchnorm --batch-size 2048 --is-no-progress-bar --is-monitor-test
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w0_l001_b2048_lars --weight-decay 0 --lr 0.01 --batch-size 2048 --is-lars --is-no-progress-bar --is-monitor-test
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-6_l001_b2048_lars --weight-decay 1e-6 --lr 0.01 --batch-size 2048 --is-lars --is-no-progress-bar --is-monitor-test
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-6_l01_bn_2048 --weight-decay 1e-6 --lr 0.1 --is-batchnorm --batch-size 2048 --is-no-progress-bar --is-monitor-test
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-2_l1e-3_b2048_adamw --weight-decay 1e-2 --lr 1e-3 --batch-size 2048 --is-no-progress-bar --is-monitor-test --is-adamw
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-2_l3e-3_b2048_adamw --weight-decay 1e-2 --lr 3e-3 --batch-size 2048 --is-no-progress-bar --is-monitor-test --is-adamw
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-2_l3e-4_b2048_adamw --weight-decay 1e-2 --lr 3e-4 --batch-size 2048 --is-no-progress-bar --is-monitor-test --is-adamw
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-2_l1e-4_b2048_adamw --weight-decay 1e-2 --lr 1e-4 --batch-size 2048 --is-no-progress-bar --is-monitor-test --is-adamw
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-3_l3e-4_b2048_adamw --weight-decay 1e-3 --lr 3e-4 --batch-size 2048 --is-no-progress-bar --is-monitor-test --is-adamw
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-4_l3e-4_b2048_adamw --weight-decay 1e-4 --lr 3e-4 --batch-size 2048 --is-no-progress-bar --is-monitor-test --is-adamw
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w1e-1_l3e-4_b2048_adamw --weight-decay 1e-1 --lr 3e-4 --batch-size 2048 --is-no-progress-bar --is-monitor-test --is-adamw
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w3e-2_l3e-4_b2048_adamw --weight-decay 3e-2 --lr 3e-4 --batch-size 2048 --is-no-progress-bar --is-monitor-test --is-adamw
python tools/linear_eval.py --no-wandb --feature-path "$feature_dir" --out-path "$dir"/eval_w3e-3_l3e-4_b2048_adamw --weight-decay 3e-3 --lr 3e-4 --batch-size 2048 --is-no-progress-bar --is-monitor-test --is-adamw
if [[ -f "$dir"/eval ]]; then
    rm -rf "$feature_dir"
fi
EOT
