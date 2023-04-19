#!/bin/bash
#
lzma -k -f -d VDB.fa.lzma
#
rm -f DS*_*.fq
rm -f DS*_.sam
rm -f DS*.bam
#
gto_fasta_extract_read_by_pattern -p "AY386330.1" < VDB.fa > B19.fa
gto_fasta_extract_read_by_pattern -p "DQ479959.1" < VDB.fa > VZV.fa
gto_fasta_extract_read_by_pattern -p "KU298932.1" < VDB.fa > HPV.fa
#gto_fasta_extract_read_by_pattern -p "NC_045512.2" < VDB.fa > COV.fa
gto_fasta_extract_read_by_pattern -p "KX827417.1" < VDB.fa > MCPyV.fa
gto_fasta_extract_read_by_pattern -p "AB116086.1" < VDB.fa > HBV.fa
#
#
# MUTATE SEQUENCES:
#
gto_fasta_mutate -s 1 -e 0.01 < B19.fa > B19-1.fa
gto_fasta_mutate -s 2 -e 0.03 < B19.fa > B19-2.fa
gto_fasta_mutate -s 3 -e 0.05 < B19.fa > B19-3.fa
gto_fasta_mutate -s 4 -e 0.07 < B19.fa > B19-4.fa
gto_fasta_mutate -s 5 -e 0.09 < B19.fa > B19-5.fa
gto_fasta_mutate -s 6 -e 0.11 < B19.fa > B19-6.fa
gto_fasta_mutate -s 7 -e 0.13 < B19.fa > B19-7.fa
gto_fasta_mutate -s 8 -e 0.15 < B19.fa > B19-8.fa
gto_fasta_mutate -s 9 < B19.fa > B19-9.fa
#
gto_fasta_mutate -s 1 -e 0.01 < HPV.fa > HPV-1.fa
gto_fasta_mutate -s 2 -e 0.03 < HPV.fa > HPV-2.fa
gto_fasta_mutate -s 3 -e 0.05 < HPV.fa > HPV-3.fa
gto_fasta_mutate -s 4 -e 0.07 < HPV.fa > HPV-4.fa
gto_fasta_mutate -s 5 -e 0.09 < HPV.fa > HPV-5.fa
gto_fasta_mutate -s 6 -e 0.11 < HPV.fa > HPV-6.fa
gto_fasta_mutate -s 7 -e 0.13 < HPV.fa > HPV-7.fa
gto_fasta_mutate -s 8 -e 0.15 < HPV.fa > HPV-8.fa
gto_fasta_mutate -s 9 < HPV.fa > HPV-9.fa
#
gto_fasta_mutate -s 1 -e 0.01 < VZV.fa > VZV-1.fa
gto_fasta_mutate -s 2 -e 0.03 < VZV.fa > VZV-2.fa
gto_fasta_mutate -s 3 -e 0.05 < VZV.fa > VZV-3.fa
gto_fasta_mutate -s 4 -e 0.07 < VZV.fa > VZV-4.fa
gto_fasta_mutate -s 5 -e 0.09 < VZV.fa > VZV-5.fa
gto_fasta_mutate -s 6 -e 0.11 < VZV.fa > VZV-6.fa
gto_fasta_mutate -s 7 -e 0.13 < VZV.fa > VZV-7.fa
gto_fasta_mutate -s 8 -e 0.15 < VZV.fa > VZV-8.fa
gto_fasta_mutate -s 9 < VZV.fa > VZV-9.fa
#
gto_fasta_mutate -s 1 -e 0.01 < HBV.fa > HBV-1.fa
gto_fasta_mutate -s 2 -e 0.03 < HBV.fa > HBV-2.fa
gto_fasta_mutate -s 3 -e 0.05 < HBV.fa > HBV-3.fa
gto_fasta_mutate -s 4 -e 0.07 < HBV.fa > HBV-4.fa
gto_fasta_mutate -s 5 -e 0.09 < HBV.fa > HBV-5.fa
gto_fasta_mutate -s 6 -e 0.11 < HBV.fa > HBV-6.fa
gto_fasta_mutate -s 7 -e 0.13 < HBV.fa > HBV-7.fa
gto_fasta_mutate -s 8 -e 0.15 < HBV.fa > HBV-8.fa
gto_fasta_mutate -s 9 < HBV.fa > HBV-9.fa
#
gto_fasta_mutate -s 1 -e 0.01 < MCPyV.fa > MCPyV-1.fa
gto_fasta_mutate -s 2 -e 0.03 < MCPyV.fa > MCPyV-2.fa
gto_fasta_mutate -s 3 -e 0.05 < MCPyV.fa > MCPyV-3.fa
gto_fasta_mutate -s 4 -e 0.07 < MCPyV.fa > MCPyV-4.fa
gto_fasta_mutate -s 5 -e 0.09 < MCPyV.fa > MCPyV-5.fa
gto_fasta_mutate -s 6 -e 0.11 < MCPyV.fa > MCPyV-6.fa
gto_fasta_mutate -s 7 -e 0.13 < MCPyV.fa > MCPyV-7.fa
gto_fasta_mutate -s 8 -e 0.15 < MCPyV.fa > MCPyV-8.fa
gto_fasta_mutate -s 9 < MCPyV.fa > MCPyV-9.fa
#
#
# CREATE RANDOM FASTA SEQUENCES AS CONTAMINATION:
#
AlcoR simulation --rand-segment 50000:0:1:0.3:0.0:0.0 > tmp1.fa
AlcoR simulation --rand-segment 50000:0:1:0.6:0.0:0.0 > tmp2.fa
#
#
# GET MITOCHONDRIAL SEQUENCE:
#
gto_fasta_extract_read_by_pattern -p "NC_012920.1" < VDB.fa > MT.fa
#
# CREATE DATASETS:
#
rm -f DS*.fa;
cat B19-1.fa HPV-1.fa VZV-1.fa HBV-1.fa MCPyV-1.fa > DS1.fa
cp DS1.fa DS2.fa
cp DS1.fa DS3.fa
cp DS1.fa DS4.fa
cp DS1.fa DS5.fa
cp DS1.fa DS6.fa
cp DS1.fa DS7.fa
cp DS1.fa DS8.fa
#
cat B19-1.fa HPV-1.fa VZV-1.fa HBV-1.fa MCPyV-1.fa tmp1.fa > DS9.fa
cp DS9.fa DS10.fa
cp DS9.fa DS11.fa
cp DS9.fa DS12.fa
cp DS9.fa DS13.fa
cp DS9.fa DS14.fa
cp DS9.fa DS15.fa
cp DS9.fa DS16.fa
#
#
cat B19-9.fa HPV-9.fa VZV-9.fa HBV-9.fa MCPyV-9.fa tmp1.fa MT.fa > DS17.fa
cat B19-2.fa HPV-2.fa VZV-2.fa HBV-2.fa MCPyV-2.fa tmp1.fa MT.fa > DS18.fa
cat B19-3.fa HPV-3.fa VZV-3.fa HBV-3.fa MCPyV-3.fa tmp1.fa MT.fa > DS19.fa
cat B19-4.fa HPV-4.fa VZV-4.fa HBV-4.fa MCPyV-4.fa tmp1.fa MT.fa > DS20.fa
cat B19-5.fa HPV-5.fa VZV-5.fa HBV-5.fa MCPyV-5.fa tmp1.fa MT.fa > DS21.fa
cat B19-6.fa HPV-6.fa VZV-6.fa HBV-6.fa MCPyV-6.fa tmp1.fa MT.fa > DS22.fa
cat B19-7.fa HPV-7.fa VZV-7.fa HBV-7.fa MCPyV-7.fa tmp1.fa MT.fa > DS23.fa
cat B19-8.fa HPV-8.fa VZV-8.fa HBV-8.fa MCPyV-8.fa tmp1.fa MT.fa > DS24.fa
#
cp DS17.fa DS25.fa
cp DS18.fa DS26.fa
cp DS19.fa DS27.fa
cp DS20.fa DS28.fa
cp DS21.fa DS29.fa
cp DS22.fa DS30.fa
cp DS23.fa DS31.fa
cp DS24.fa DS32.fa
#
cp DS17.fa DS33.fa
cp DS18.fa DS34.fa
cp DS19.fa DS35.fa
cp DS20.fa DS36.fa
cp DS21.fa DS37.fa
cp DS22.fa DS38.fa
cp DS23.fa DS39.fa
cp DS24.fa DS40.fa
#
cp DS17.fa DS41.fa
cp DS18.fa DS42.fa
cp DS19.fa DS43.fa
cp DS20.fa DS44.fa
cp DS21.fa DS45.fa
cp DS22.fa DS46.fa
cp DS23.fa DS47.fa
cp DS24.fa DS48.fa
#
cp DS17.fa DS49.fa
cp DS18.fa DS50.fa
cp DS19.fa DS51.fa
cp DS20.fa DS52.fa
cp DS21.fa DS53.fa
cp DS22.fa DS54.fa
cp DS23.fa DS55.fa
cp DS24.fa DS56.fa
#
cat B19-1.fa HPV-1.fa VZV-1.fa HBV-1.fa MCPyV-1.fa tmp1.fa > DS57.fa
cat B19-1.fa HPV-1.fa VZV-1.fa HBV-1.fa MCPyV-1.fa MT.fa > DS58.fa
#
cat B19-2.fa HPV-2.fa VZV-2.fa HBV-2.fa MCPyV-2.fa tmp1.fa MT.fa > DS59.fa
cat B19-3.fa HPV-3.fa VZV-3.fa HBV-3.fa MCPyV-3.fa tmp2.fa MT.fa > DS60.fa
#
cat B19-1.fa HPV-1.fa VZV-1.fa HBV-1.fa MCPyV-1.fa tmp2.fa MT.fa > DS61.fa
cp DS61.fa DS62.fa
#
#
# SIMULATE FASTQ READS:
#
art_illumina -rs 1  -i DS1.fa -p -sam -l 150 -f 2 -m 200 -s 10 -o DS1_
art_illumina -rs 2  -i DS2.fa -p -sam -l 150 -f 5 -m 200 -s 10 -o DS2_
art_illumina -rs 3  -i DS3.fa -p -sam -l 150 -f 10 -m 200 -s 10 -o DS3_
art_illumina -rs 4  -i DS4.fa -p -sam -l 150 -f 15 -m 200 -s 10 -o DS4_
art_illumina -rs 5  -i DS5.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS5_
art_illumina -rs 6  -i DS6.fa -p -sam -l 150 -f 25 -m 200 -s 10 -o DS6_
art_illumina -rs 7  -i DS7.fa -p -sam -l 150 -f 30 -m 200 -s 10 -o DS7_
art_illumina -rs 8  -i DS8.fa -p -sam -l 150 -f 40 -m 200 -s 10 -o DS8_
#
art_illumina -rs 9  -i DS9.fa -p -sam -l 150 -f 2 -m 200 -s 10 -o DS9_
art_illumina -rs 10  -i DS10.fa -p -sam -l 150 -f 5 -m 200 -s 10 -o DS10_
art_illumina -rs 11  -i DS11.fa -p -sam -l 150 -f 10 -m 200 -s 10 -o DS11_
art_illumina -rs 12  -i DS12.fa -p -sam -l 150 -f 15 -m 200 -s 10 -o DS12_
art_illumina -rs 13  -i DS13.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS13_
art_illumina -rs 14  -i DS14.fa -p -sam -l 150 -f 25 -m 200 -s 10 -o DS14_
art_illumina -rs 15  -i DS15.fa -p -sam -l 150 -f 30 -m 200 -s 10 -o DS15_
art_illumina -rs 16  -i DS16.fa -p -sam -l 150 -f 40 -m 200 -s 10 -o DS16_
#
art_illumina -rs 17  -i DS17.fa -p -sam -l 150 -f 2 -m 200 -s 10 -o DS17_
art_illumina -rs 18  -i DS18.fa -p -sam -l 150 -f 2 -m 200 -s 10 -o DS18_
art_illumina -rs 19  -i DS19.fa -p -sam -l 150 -f 2 -m 200 -s 10 -o DS19_
art_illumina -rs 20  -i DS20.fa -p -sam -l 150 -f 2 -m 200 -s 10 -o DS20_
art_illumina -rs 21  -i DS21.fa -p -sam -l 150 -f 2 -m 200 -s 10 -o DS21_
art_illumina -rs 22  -i DS22.fa -p -sam -l 150 -f 2 -m 200 -s 10 -o DS22_
art_illumina -rs 23  -i DS23.fa -p -sam -l 150 -f 2 -m 200 -s 10 -o DS23_
art_illumina -rs 24  -i DS24.fa -p -sam -l 150 -f 2 -m 200 -s 10 -o DS24_
#
art_illumina -rs 25  -i DS25.fa -p -sam -l 150 -f 5 -m 200 -s 10 -o DS25_
art_illumina -rs 26  -i DS26.fa -p -sam -l 150 -f 5 -m 200 -s 10 -o DS26_
art_illumina -rs 27  -i DS27.fa -p -sam -l 150 -f 5 -m 200 -s 10 -o DS27_
art_illumina -rs 28  -i DS28.fa -p -sam -l 150 -f 5 -m 200 -s 10 -o DS28_
art_illumina -rs 29  -i DS29.fa -p -sam -l 150 -f 5 -m 200 -s 10 -o DS29_
art_illumina -rs 30  -i DS30.fa -p -sam -l 150 -f 5 -m 200 -s 10 -o DS30_
art_illumina -rs 31  -i DS31.fa -p -sam -l 150 -f 5 -m 200 -s 10 -o DS31_
art_illumina -rs 32  -i DS32.fa -p -sam -l 150 -f 5 -m 200 -s 10 -o DS32_
#
art_illumina -rs 33  -i DS33.fa -p -sam -l 150 -f 10 -m 200 -s 10 -o DS33_
art_illumina -rs 34  -i DS34.fa -p -sam -l 150 -f 10 -m 200 -s 10 -o DS34_
art_illumina -rs 35  -i DS35.fa -p -sam -l 150 -f 10 -m 200 -s 10 -o DS35_
art_illumina -rs 36  -i DS36.fa -p -sam -l 150 -f 10 -m 200 -s 10 -o DS36_
art_illumina -rs 37  -i DS37.fa -p -sam -l 150 -f 10 -m 200 -s 10 -o DS37_
art_illumina -rs 38  -i DS38.fa -p -sam -l 150 -f 10 -m 200 -s 10 -o DS38_
art_illumina -rs 39  -i DS39.fa -p -sam -l 150 -f 10 -m 200 -s 10 -o DS39_
art_illumina -rs 40  -i DS40.fa -p -sam -l 150 -f 10 -m 200 -s 10 -o DS40_
#
art_illumina -rs 41  -i DS41.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS41_
art_illumina -rs 42  -i DS42.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS42_
art_illumina -rs 43  -i DS43.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS43_
art_illumina -rs 44  -i DS44.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS44_
art_illumina -rs 45  -i DS45.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS45_
art_illumina -rs 46  -i DS46.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS46_
art_illumina -rs 47  -i DS47.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS47_
art_illumina -rs 48  -i DS48.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS48_
#
art_illumina -rs 49  -i DS49.fa -p -sam -l 150 -f 40 -m 200 -s 10 -o DS49_
art_illumina -rs 50  -i DS50.fa -p -sam -l 150 -f 40 -m 200 -s 10 -o DS50_
art_illumina -rs 51  -i DS51.fa -p -sam -l 150 -f 40 -m 200 -s 10 -o DS51_
art_illumina -rs 52  -i DS52.fa -p -sam -l 150 -f 40 -m 200 -s 10 -o DS52_
art_illumina -rs 53  -i DS53.fa -p -sam -l 150 -f 40 -m 200 -s 10 -o DS53_
art_illumina -rs 54  -i DS54.fa -p -sam -l 150 -f 40 -m 200 -s 10 -o DS54_
art_illumina -rs 55  -i DS55.fa -p -sam -l 150 -f 40 -m 200 -s 10 -o DS55_
art_illumina -rs 56  -i DS56.fa -p -sam -l 150 -f 40 -m 200 -s 10 -o DS56_
#
art_illumina -rs 57  -i DS57.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS57_
art_illumina -rs 58  -i DS58.fa -p -sam -l 150 -f 20 -m 200 -s 10 -o DS58_
#
art_illumina -rs 59  -i DS59.fa -p -sam -l 150 -f 30 -m 200 -s 10 -o DS59_
#
art_illumina -rs 60  -i DS60.fa -p -sam -l 150 -f 40 -m 200 -s 10 -o DS60_
#
art_illumina -rs 61  -i DS61.fa -p -sam -l 75 -f 20 -m 200 -s 10 -o DS61_
art_illumina -rs 62  -i DS62.fa -p -sam -l 250 -f 20 -m 400 -s 10 -o DS62_
#
rm *.aln *.sam
#
