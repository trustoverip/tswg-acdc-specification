#!/bin/bash

# Create trefs directory
mkdir -p trefs

# List of filenames
files=(
    "attribute"
    "autonomic-identifier"
    "chain-link-confidential-disclosure"
    "compact-disclosure"
    "contractually-protected-disclosure"
    "controller"
    "disclosee"
    "discloser"
    "duplicity"
    "edge"
    "framing-code"
    "full-disclosure"
    "graduated-disclosure"
    "inception-event"
    "interaction-event"
    "issuee"
    "issuer"
    "operator"
    "partial-disclosure"
    "percolated-discovery"
    "rotation-event"
    "rules"
    "schema"
    "selective-disclosure"
    "self-addressing-identifier-(said)"
    "stream"
    "targeted-acdc"
    "untargeted-acdc"
)

# Create markdown files with specified content
for file in "${files[@]}"; do
    echo "[[tref: kmg-1, $file]]" > "trefs/$file.md"
done