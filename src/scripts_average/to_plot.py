
tools_available = ["coronaspades","haploflow","irma","lazypipe","metaspades","metaviralspades","pehaplo",
                   "qure","qvg","spades","ssake","tracespipe","tracespipelite","virgena","vispa", "v"]

correct_names = ["coronaSPAdes","Haploflow","IRMA","LAZYPIPE","metaSPAdes","metaviralSPAdes","PEHaplo",
                   "QuRe","QVG","SPAdes","SSAKE","TRACESPipe","TRACESPipeLite","VirGenA","ViSpA", "V-pipe"]

dict_time = {}
dict_snp = {}
dict_identity = {}
dict_ncd = {}
dict_nrc = {}
dict_mem = {}
dict_cpu = {}
dict_nr_contigs = {}

dict_recon_bases = {}
dict_min_len = {}
dict_max_length = {}
dict_avg_length = {}

dict_recon_bases_wout_n = {}
dict_min_length_wout_n = {}
dict_max_length_wout_n = {}
dict_avg_length_wout_n = {}

dict_snps_nr_bases_w_n = {}
dict_snps_nr_bases_wout_n = {}


cases = 3


def add_to_dict(key, val, sel_dict): #new dict entry if not exists with value val, add value to the entry if exists

    if key in sel_dict:
        # append the new number to the existing array at this slot
        sel_dict[key] = [sel_dict[key][0] + val, sel_dict[key][1] + 1]
    else:
        # create a new array in this slot
        sel_dict[key] = [val, 1]

def add_vals_dict(line): #adds vals of performance to dict. key is tool, vals are performance
#time SNPs	AvgIdentity	NCD	NRC	Mem(GB)	%CPU	Nr contigs
    list_vals = line.split('\t')

    add_to_dict(list_vals[1].split("-")[0], float(list_vals[2]), dict_time)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[3]), dict_snp)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[4]), dict_identity)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[5]), dict_ncd)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[6]), dict_nrc)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[7]), dict_mem)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[8].split("%")[0]), dict_cpu)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[9]), dict_nr_contigs)


    add_to_dict(list_vals[1].split("-")[0], float(list_vals[15]), dict_recon_bases)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[16]), dict_min_len)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[17]), dict_max_length)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[18]), dict_avg_length)

    add_to_dict(list_vals[1].split("-")[0], float(list_vals[19]), dict_recon_bases_wout_n)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[20]), dict_min_length_wout_n)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[21]), dict_max_length_wout_n)
    add_to_dict(list_vals[1].split("-")[0], float(list_vals[22]), dict_avg_length_wout_n)

    add_to_dict(list_vals[1].split("-")[0], float(list_vals[23]), dict_snps_nr_bases_w_n)

    try:
        add_to_dict(list_vals[1].split("-")[0], float(list_vals[24]), dict_snps_nr_bases_wout_n)
        
    except:
        pass


    #add_to_dict(list_vals[1].split("-")[0], float(list_vals[19]), dict_recon_bases_wout_n)

def name_converter(key):
    idx = tools_available.index(key)
    return correct_names[idx]


def avg_dicts(dict_to_avg, name_file): #averages the dictionaries
    file = open(name_file, "w")
    dict_sel = dict(sorted(dict_to_avg.items()))

    for key in dict_sel:
        average_value = dict_sel[key][0] / dict_sel[key][1]
        file.write(name_converter(key) + "\t" + str(round(average_value, cases)) + "\n")

    file.close()

def calculate_nr_genomes_reconstructed (dictionary, name_file): #writes to file how many genomes were reconstructed by the tools
    file = open(name_file, "w")
    dict_sel = dict(sorted(dictionary.items()))

    for key in dict_sel:
        file.write(name_converter(key) + "\t" + str(dict_sel[key][1]) + "\n")

    file.close()


'''def normalize_values(dictionary):

    list_vals = []

    for i in dictionary:
        list_vals.append(dictionary[i][0])

    min_val = min(list_vals)
    max_val = max(list_vals)

    count = 0
    for i in dictionary:

        #TODO
        normalized_val =

        normalized_val = (list_vals[count] - min_val) / (max_val - min_val)
        dictionary[i] = [normalized_val / dictionary[i][1]]
        count += 1'''




def import_files_in_dir(file_name): #adds the values contained in the input .tsv file to a dictionary and averages the values added

    is_first_line = True
    file_op = open(file_name, "r")

    for line in file_op:

        if is_first_line == False:
            add_vals_dict(line)
        else:
            is_first_line = False

    avg_dicts(dict_time, "time.tsv")
    avg_dicts(dict_snp, "snp.tsv")
    avg_dicts(dict_identity, "identity.tsv")
    avg_dicts(dict_ncd, "ncsd.tsv")
    avg_dicts(dict_nrc, "nrc.tsv")
    avg_dicts(dict_mem, "mem.tsv")
    avg_dicts(dict_cpu, "cpu.tsv")
    avg_dicts(dict_nr_contigs, "contigs.tsv")

    avg_dicts(dict_recon_bases, "recon_bases.tsv")
    avg_dicts(dict_min_len, "min_length.tsv")
    avg_dicts(dict_max_length, "max_length.tsv")
    avg_dicts(dict_avg_length, "avg_length.tsv")

    avg_dicts(dict_recon_bases_wout_n, "recon_bases_wout_n.tsv")
    avg_dicts(dict_min_length_wout_n, "min_len_wout_n.tsv")
    avg_dicts(dict_max_length_wout_n, "max_len_wout_n.tsv")
    avg_dicts(dict_avg_length_wout_n, "avg_len_wout_n.tsv")

    avg_dicts(dict_snps_nr_bases_w_n, "snps_nr_bases_w_n.tsv")
    avg_dicts(dict_snps_nr_bases_wout_n, "snps_nr_bases_wout_n.tsv")

    file_ncsd_cpu = open("ncsd_cpu.tsv", "w")
    file_ncsd_ram = open("ncsd_ram.tsv", "w")
    file_ncsd_time = open("ncsd_time.tsv", "w")


    for i in dict_ncd:

        avg_ncsd = (dict_ncd[i][0] / dict_ncd[i][1])
        avg_cpu = dict_cpu[i][0] / dict_cpu[i][1]
        avg_ram = dict_mem[i][0] / dict_mem[i][1]
        avg_time = dict_time[i][0] / dict_time[i][1]

        file_ncsd_cpu.write(name_converter(i) + "\t" + str(round(avg_cpu * avg_ncsd, cases)) + "\n")
        file_ncsd_ram.write(name_converter(i) + "\t" + str(round(avg_ram * avg_ncsd, cases)) + "\n")
        file_ncsd_time.write(name_converter(i) + "\t" + str(round(avg_time * avg_ncsd, cases)) + "\n")

    file_ncsd_cpu.close()
    file_ncsd_ram.close()
    file_ncsd_time.close()



    calculate_nr_genomes_reconstructed(dict_ncd, "reconstructed.tsv")






def exec_avgs():

    file_name = "total_avg_stats.tsv"
    import_files_in_dir(file_name)
