#!/bin/bash
#
#declare -a TOOLS=("coronaSPAdes" "Haploflow" "LAZYPIPE" "metaSPAdes" "metaviralSPAdes" "PEHaplo" "QuRe" "QVG" "SPAdes" "SSAKE" "TRACESPipe" "TRACESPipeLite" "VirGenA" "ViSpA" "V-pipe")
#declare -a list
#declare -p list
#
rm -rf Graphs
mkdir Graphs
#
#list_files=($(ls))
#  
#printf "${list[*]} \n\n"
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity.pdf"
    set datafile separator "\t"
    set boxwidth 0.5
    
    spacing_x = 30
    ymax = 100
    ymin = 75 
    set yrange [ymin:ymax]
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Average Identity"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1 


    plot "identity.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Contigs.pdf"
    set datafile separator "\t"
    set boxwidth 0.5
    
    spacing_x = 30
    set autoscale y
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Number of scaffolds"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1 


    plot "contigs.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "CPU.pdf"
    set datafile separator "\t"
    set boxwidth 0.5
    
    spacing_x = 30
    set autoscale y
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "CPU"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1 


    plot "cpu.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "RAM.pdf"
    set datafile separator "\t"
    set boxwidth 0.5
    
    spacing_x = 30
    set autoscale y
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "RAM"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1 


    plot "mem.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD.pdf"
    set datafile separator "\t"
    set boxwidth 0.5
    
    spacing_x = 30
    set autoscale y
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "NCSD"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1 


    plot "ncsd.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC.pdf"
    set datafile separator "\t"
    set boxwidth 0.5
    
    spacing_x = 30
    set autoscale y
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "NRC"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1 


    plot "nrc.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "SNPs.pdf"
    set datafile separator "\t"
    set boxwidth 0.5
    
    spacing_x = 30
    set autoscale y
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "SNPs"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1 


    plot "snp.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "time.pdf"
    set datafile separator "\t"
    set boxwidth 0.5
    
    spacing_x = 30
    set autoscale y
    set logscale y 2
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Execution Time"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1 


    plot "time.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "reconstructed.pdf"
    set datafile separator "\t"
    set boxwidth 0.5
    
    spacing_x = 30
    set yrange [0:]
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Datasets Reconstructed"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1 


    plot "reconstructed.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "weighted_time.pdf"
    set datafile separator "\t"
    set boxwidth 0.5

    spacing_x = 30
    set yrange [0:]
    set xrange [-1:16]
    set logscale y 2

    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Weighted performance of the time using the NCSD"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1

    plot "ncsd_time.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "weighted_CPU.pdf"
    set datafile separator "\t"
    set boxwidth 0.5

    spacing_x = 30
    set yrange [0:]
    set xrange [-1:16]

    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Weighted performance of the CPU using the NCSD"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1


    plot "ncsd_cpu.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "weighted_RAM.pdf"
    set datafile separator "\t"
    set boxwidth 0.5

    spacing_x = 30
    set yrange [0:]
    set xrange [-1:16]

    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Weighted performance of the RAM using the NCSD"
    set xlabel "Reconstruction Programs"
    set multiplot layout 1,1
    set rmargin 5
    set key at screen 1, graph 1


    plot "ncsd_ram.tsv" using 0:2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "reconstructed_nr_bases.pdf"
    set datafile separator "\t"
    
    set style data histogram
    set style histogram cluster
    
    set boxwidth 0.25
    
    set autoscale y
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Number of bases reconstructed"
    set xlabel "Reconstruction Programs"

    set rmargin 5
    


    plot 'recon_bases.tsv' using (column(0)):0.0:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle, \
    'recon_bases_wout_n.tsv' using (column(0)+0.125):2 with boxes lc rgb "#d3804a" fill solid 0.5 notitle, \
    'recon_bases.tsv' using (column(0)-0.125):2 with boxes lc rgb "#067188" fill solid 0.5 notitle,
    

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "min_length.pdf"
    set datafile separator "\t"
    
    set style data histogram
    set style histogram cluster
    
    set boxwidth 0.25
    
    set autoscale y
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Minimum length per contig reconstructed"
    set xlabel "Reconstruction Programs"

    set rmargin 5
    


    plot 'min_length.tsv' using (column(0)):0.0:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle, \
    'min_len_wout_n.tsv' using (column(0)+0.125):2 with boxes lc rgb "#d3804a" fill solid 0.5 notitle, \
    'min_length.tsv' using (column(0)-0.125):2 with boxes lc rgb "#067188" fill solid 0.5 notitle,
    

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "max_length.pdf"
    set datafile separator "\t"
    
    set style data histogram
    set style histogram cluster
    
    set boxwidth 0.25
    
    set autoscale y
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Maximum length per contig reconstructed"
    set xlabel "Reconstruction Programs"

    set rmargin 5
    


    plot 'max_length.tsv' using (column(0)):0.0:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle, \
    'max_len_wout_n.tsv' using (column(0)+0.125):2 with boxes lc rgb "#d3804a" fill solid 0.5 notitle, \
    'max_length.tsv' using (column(0)-0.125):2 with boxes lc rgb "#067188" fill solid 0.5 notitle,
    

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "avg_length.pdf"
    set datafile separator "\t"
    
    set style data histogram
    set style histogram cluster
    
    set boxwidth 0.25
    
    set autoscale y
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Average length per contig reconstructed"
    set xlabel "Reconstruction Programs"

    set rmargin 5
    


    plot 'avg_length.tsv' using (column(0)):0.0:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle, \
    'avg_len_wout_n.tsv' using (column(0)+0.125):2 with boxes lc rgb "#d3804a" fill solid 0.5 notitle, \
    'avg_length.tsv' using (column(0)-0.125):2 with boxes lc rgb "#067188" fill solid 0.5 notitle,
    

EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "snps_nr_bases.pdf"
    set datafile separator "\t"
    
    set style data histogram
    set style histogram cluster
    
    set boxwidth 0.25
    
    set autoscale y
    set xrange [-1:16]
   
    set ytics auto
    set xtics rotate by 45 right
    set ylabel "Ratio of the number of SNPs in relation to\nthe number of bases reconstructed"
    set xlabel "Reconstruction Programs"

    set rmargin 5
    


    plot 'snps_nr_bases_w_n.tsv' using (column(0)-0.125):2:xtic(1) with boxes lc rgb "#067188" fill solid 0.5 notitle, \
    'snps_nr_bases_wout_n.tsv' using (column(0)+0.125):2 with boxes lc rgb "#d3804a" fill solid 0.5 notitle \
    
    

EOF
#
mv *.pdf Graphs
