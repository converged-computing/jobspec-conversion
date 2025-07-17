#!/bin/bash
#FLUX: --job-name=slr-e-c
#FLUX: -t=604800
#FLUX: --urgency=16

source activate lensing
base=/scratch/jb6504/recycling_strong_lensing/
cd $base/
for tag in fix mass align full
do
    modeltag=${tag}
    echo ""
    echo ""
    echo ""
    echo "Evaluating ${modeltag} on prior sample"
    echo ""
    python -u test.py carl_${modeltag} test_${tag}_prior carl_${modeltag}_prior --dir $base
    echo ""
    echo ""
    echo ""
    echo "Evaluating ${modeltag} on shuffled prior sample"
    echo ""
    python -u test.py carl_${modeltag} test_${tag}_prior carl_${modeltag}_shuffledprior --shuffle --dir $base
    echo ""
    echo ""
    echo ""
    echo "Evaluating ${modeltag} on point sample / param grid"
    echo ""
    python -u test.py carl_${modeltag} test_${tag}_point carl_${modeltag}_grid --grid --dir $base
done
