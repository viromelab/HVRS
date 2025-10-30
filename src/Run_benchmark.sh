#!/bin/bash
#
./Installation.sh --all
./Simulation.sh
./Verification.sh --all -c
./Reconstruction.sh --all
./Evaluation.sh
./Plots.sh
./Cleaning.sh
#
