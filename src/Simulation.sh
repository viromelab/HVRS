#!/bin/bash
#
zcat MINIDB.fa.gz > VDB.fa
#
gto_fasta_extract_read_by_pattern -p "Synthetic DNA generated with gto" < VDB.fa > SVA.fa
gto_fasta_extract_read_by_pattern -p "AY386330.1" < VDB.fa > B19.fa
gto_fasta_extract_read_by_pattern -p "X04370.1" < VDB.fa > HV3.fa
gto_fasta_extract_read_by_pattern -p "MG921180.1" < VDB.fa > HPV.fa
#
#
# MUTATE SEQUENCES:
#
gto_fasta_mutate -s 0 -e 0.01 < SVA.fa > SVA_1.fa
gto_fasta_mutate -s 0 -e 0.03 < SVA.fa > SVA_2.fa
gto_fasta_mutate -s 0 -e 0.05 < SVA.fa > SVA_3.fa
#
gto_fasta_mutate -s 0 -e 0.01 < B19.fa > B19_1.fa
gto_fasta_mutate -s 0 -e 0.03 < B19.fa > B19_2.fa
gto_fasta_mutate -s 0 -e 0.05 < B19.fa > B19_3.fa
#
gto_fasta_mutate -s 0 -e 0.01 < HPV.fa > HPV_1.fa
gto_fasta_mutate -s 0 -e 0.03 < HPV.fa > HPV_2.fa
gto_fasta_mutate -s 0 -e 0.05 < HPV.fa > HPV_3.fa
#
gto_fasta_mutate -s 0 -e 0.01 < HV4.fa > HV4_1.fa
gto_fasta_mutate -s 0 -e 0.03 < HV4.fa > HV4_2.fa
gto_fasta_mutate -s 0 -e 0.05 < HV4.fa > HV4_3.fa
#
#
# CREATE DATASETS:
#
cat SVA_1.fa B19_1.fa HPV_1.fa HV4_1.fa > DS1.fa
cat SVA_2.fa B19_2.fa HPV_2.fa HV4_2.fa > DS2.fa
cat SVA_3.fa B19_3.fa HPV_3.fa HV4_3.fa > DS3.fa
#
#
# SIMULATE FASTQ READS:
#
art_illumina -rs 0 -ss HS25 -sam -i DS1.fa -p -l 150 -f 10 -m 200 -s 10 -o DS1
art_illumina -rs 0 -ss HS25 -sam -i DS2.fa -p -l 150 -f 20 -m 200 -s 10 -o DS2
art_illumina -rs 0 -ss HS25 -sam -i DS3.fa -p -l 150 -f 30 -m 200 -s 10 -o DS3
#
