#!/bin/bash
#FLUX: --job-name=StyleGAN-2
#FLUX: -t=60
#FLUX: --urgency=16

module load nixpkgs/16.09  intel/2018.3  cuda/10.0.130 cudnn/7.5
source ~/BlissStyleGAN/StyleGAN2/pytorch/bin/activate
echo -n "SLURM temporary directory: "
echo "$SLURM_TMPDIR"
echo
mkdir $SLURM_TMPDIR/blissSingleCharGrey
tar xf ~/BlissStyleGAN/blissSingleCharsGrey.tar -C "$SLURM_TMPDIR/blissSingleCharGrey"
ls -R $SLURM_TMPDIR/blissSingleCharGrey
PREPPED_DATA_DIR="preppedBlissSingleCharGrey"
OUTPUT_DIR="$SLURM_TMPDIR/$PREPPED_DATA_DIR"
mkdir "$OUTPUT_DIR"
INPUT_DIR="$SLURM_TMPDIR/blissSingleCharGrey/blissSingleCharsInGrayscale"
python ~/BlissStyleGAN/StyleGAN2/stylegan2-ada-pytorch/dataset_tool.py --source "$INPUT_DIR" --dest "$OUTPUT_DIR"
STATUS=$?
echo "Data prep exit status is $STATUS"
ls -R "$OUTPUT_DIR"
if [ $STATUS == 0 ]; then
    tar cf ~/BlissStyleGAN/StyleGAN2/preppedBliss4Pytorch.tar -C "$SLURM_TMPDIR" "$PREPPED_DATA_DIR"
else
    echo "dataset_tool.py failed with exit status $STATUS"
fi
echo Done!
