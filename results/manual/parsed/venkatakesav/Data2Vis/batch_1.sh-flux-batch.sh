#!/bin/bash
#FLUX: --job-name=train_new_1
#FLUX: --queue=long
#FLUX: -t=345600
#FLUX: --urgency=16

echo "loading cuda, cudnn modules"
echo "running python script"
python3 /home2/patanjali.b/A_3_Part-2/3_0.py
echo "Execution completed"
deactivate
echo "------END------"
