#!/bin/bash

date
hostname

source ~/.bashrc

micromamba activate openff-param-fit

INPUT_DATA_DIR="../01-curate-data/training-datasets"


BASE_FF="amber-ff"

python 4-create-forcebalance-inputs.py                  \
    --tag               "${BASE_FF}-default-weight"     \
    --port              53135                           \
    --force-field-path  "../02-create-initial-forcefields/initial-${BASE_FF}.offxml"    \
    --optimization-dataset-path "${INPUT_DATA_DIR}/optimization-training-dataset.json"  \
    --torsiondrive-dataset-path "${INPUT_DATA_DIR}/torsiondrive-training-dataset.json"  \
    --valence-smirks-path        "${INPUT_DATA_DIR}/optimization-training-smirks.json"  \
    --torsion-smirks-path        "${INPUT_DATA_DIR}/torsiondrive-training-smirks.json"  \
    --smarts-to-exclude          "../01-curate-data/smarts-to-exclude.dat"              \
    --smiles-to-exclude          "../01-curate-data/smiles-to-exclude.dat"              \
    --opt-geo-weight             0.01                                                   \
    --torsiondrive-target-type   "TorsionProfile"                                       \
    --torsiondrive-weight        1.0                                                    \
    --protein-torsiondrive-weight 1.0                                                   \
    --verbose
