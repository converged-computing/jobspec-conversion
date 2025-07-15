#!/bin/bash
#FLUX: --job-name=milky-truffle-3231
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

source /home/h86chen/scratch/STEVE-1/.venv/bin/activate
cd /home/h86chen/scratch/STEVE-1-Memory
module load scipy-stack StdEnv/2020 gcc/9.3.0 cuda/11.4 opencv java/1.8.0_192 python/3.9 
COMMAND="xvfb-run python steve1/run_agent/run_agent.py \
    --in_model data/weights/vpt/2x.model \
    --in_weights data/weights/steve1/memory-16m.weights \
    --prior_weights data/weights/steve1/steve1_prior.pt \
    --text_cond_scale 6.0 \
    --visual_cond_scale 7.0 \
    --gameplay_length 3000 \
    --save_dirpath data/generated_videos/paper_prompts/memory-13m"
$COMMAND
EXIT_STATUS=$?
while [ $EXIT_STATUS -ne 0 ]; do
    echo
    echo "Encountered an error (likely internal MineRL error), restarting (will skip existing videos)..."
    echo "NOTE: If not MineRL error, then there might be a bug or the parameters might be wrong."
    sleep 10
    $COMMAND
    EXIT_STATUS=$?
done
echo "Finished generating all videos."
