#!/usr/bin/env ruby

require 'fileutils'

<<comments
This is the bare bones, fully manual copy of the program. This is finished for the thesis with no user inputs.
start date: 12/05/17
comments


# all methods
def extract_atoms
  @pdb_file = @pdb_base_name
  @pdb_file = @pdb_file.chomp + '.pdb'
  @atoms_only = File.new("#{@pdb_file.chomp('.pdb')}_atoms.pdb", 'w')
  File.open(@pdb_file, 'r') do |file|
    file.each_line do |line|
      if line.match(/^ATOM/) || line.match(/^TER/) || line.match(/^END/)
        @atoms_only.puts line
      end
    end
  end
  @atoms_only.close
end

def cns_generate_file
  # Open and fill out the generate.inp file
  system('cp file_store/generate_easy.inp .')
  generate_file = File.read("generate_easy.inp")
  sub_pdb_input = generate_file.gsub!(/{===>} coordinate_infile="input_rename_here.pdb";/, "{===>} coordinate_infile=\"#{@pdb_base_name}_atoms.pdb\";")
  @sub_pdb_output = generate_file.gsub!(/{===>} structure_outfile="output_generate_easy.mtf";/, "{===>} structure_outfile=\"#{@pdb_base_name}_output.mtf\";")
  @sub_mtf_output = generate_file.gsub!(/{===>} coordinate_outfile="output_generate_easy.pdb";/, "{===>} coordinate_outfile=\"#{@pdb_base_name}_output.pdb\";")
  generate_easy = File.open("generate_easy.inp", 'w')
  generate_easy.puts sub_pdb_input
  generate_easy.puts @sub_pdb_output
  generate_easy.puts @sub_mtf_output
end
def cns_run_generate
  system('cns < generate_easy.inp > generate.log')
end
def cns_expand_file(domain_1_start, domain_1_end, domain_2_start, domain_2_end)
  # Open and fill out the expand.inp file
  system('cp file_store/expand.inp .')
  expand_file = File.read("expand.inp")
  sub_pdb_input = expand_file.gsub!(/{===>} coordinate_infile="amy_hydrogen.pdb";/, "{===>} coordinate_infile=\"#{@pdb_base_name}_output.pdb\";")
  sub_mtf_input = expand_file.gsub!(/{===>} structure_infile="";/, "{===>} structure_infile=\"#{@pdb_base_name}_output.mtf\";")
  sub_restraint = expand_file.gsub!(/{===>} restraints_infile="";/, " {===>} restraints_infile=\"expand.def\"; ")
  sub_trajectory_output = expand_file.gsub!(/{===>} output_root="model_anneal";/, "{===>} output_root=\"#{@pdb_base_name}_model_expand.pdb\";")
  sub_domain_1 = expand_file.gsub!(/{===>} atom_rigid_1=(none);/, "{===>} atom_rigid_1=(segid A and resid #{domain_1_start}:#{domain_1_end});")
  sub_domain_2 = expand_file.gsub!(/{===>} atom_rigid_2=(none);/, "{===>} atom_rigid_2=(segid A and resid #{domain_2_start}:#{domain_2_end});")
  random = rand(10000..99999)
  sub_random_number = expand_file.gsub!(/{===>} seed=82364;/, "{===>} seed=#{random};")
  @expand = File.open('expand.inp', 'w')
  @expand.puts sub_pdb_input
  @expand.puts sub_mtf_input
  @expand.puts sub_restraint
  @expand.puts sub_trajectory_output
  @expand.puts sub_domain_1
  @expand.puts sub_domain_2
  system('cp file_store/expand.def .')
  expand_def = File.read('expand.def')
####################################################################
  sub_def_chain_1 = expand_def.gsub!(/resid chain_1/, 'resid 100') # this may require changing if there are not
  sub_def_chain_2 = expand_def.gsub!(/resid chain_2/, 'resid 100') # any residues with a resid of 100
##################################################################
  @expand_def = File.open('expand.def', 'w')
  @expand_def.puts sub_def_chain_1
  @expand_def.puts sub_def_chain_2
end
def cns_run_expand
  system('cns < expand.inp > expand.log')
end
def bins_3
  bin_1 = 0
  row_1 = [nil, nil, nil, 0]
  row_2 = [nil, nil, nil, 1]
  row_3 = [nil, nil, nil, 2]
  until row_3[0] == 2
    bin_2 = 0
    bin_3 = 0
    row_1[0] = row_2[0] = row_3[0] = bin_1
    row_1[1] = row_2[1] = row_3[1] = bin_2
    row_1[2] = row_2[2] = row_3[2] = bin_3
    until row_3[1] == 2
      bin_3 = 0
      row_1[1] = row_2[1] = row_3[1] = bin_2
      row_1[2] = row_2[2] = row_3[2] = bin_3
      until row_3[2] == 2
        row_1[2] = row_2[2] = row_3[2] = bin_3
        puts "#{row_1}"
        puts "#{row_2}"
        puts "#{row_3}"
        bin_3 += 1
      end
      bin_2 += 1
    end
    bin_1 += 1
  end
end
def bins_4
  bin_1 = 0
  row_1 = [nil, nil, nil, 0]
  row_2 = [nil, nil, nil, 1]
  row_3 = [nil, nil, nil, 2]
  row_4 = [nil, nil, nil, 3]
  until row_4[0] == 3
    bin_2 = 0
    bin_3 = 0
    row_1[0] = row_2[0] = row_3[0] = row_4[0] = bin_1
    row_1[1] = row_2[1] = row_3[1] = row_4[1] = bin_2
    row_1[2] = row_2[2] = row_3[2] = row_4[2] = bin_3
    until row_4[1] == 3
      bin_3 = 0
      row_1[1] = row_2[1] = row_3[1] = row_4[1] = bin_2
      row_1[2] = row_2[2] = row_3[2] = row_4[2] = bin_3
      until row_4[2] == 3
        row_1[2] = row_2[2] = row_3[2] = row_4[2] = bin_3
        puts "#{row_1}"
        puts "#{row_2}"
        puts "#{row_3}"
        puts "#{row_4}"
        bin_3 += 1
      end
      bin_2 += 1
    end
    bin_1 += 1
  end
end
def bins_5
  bin_1 = 0
  row_1 = [nil, nil, nil, 0]
  row_2 = [nil, nil, nil, 1]
  row_3 = [nil, nil, nil, 2]
  row_4 = [nil, nil, nil, 3]
  row_5 = [nil, nil, nil, 4]
  until row_5[0] == 4
    bin_2 = 0
    bin_3 = 0
    row_1[0] = row_2[0] = row_3[0] = row_4[0] = row_5[0] = bin_1
    row_1[1] = row_2[1] = row_3[1] = row_4[1] = row_5[1] = bin_2
    row_1[2] = row_2[2] = row_3[2] = row_4[2] = row_5[2] = bin_3
    until row_5[1] == 4
      bin_3 = 0
      row_1[1] = row_2[1] = row_3[1] = row_4[1] = row_5[1] = bin_2
      row_1[2] = row_2[2] = row_3[2] = row_4[2] = row_5[2] = bin_3
      until row_5[2] == 4
        row_1[2] = row_2[2] = row_3[2] = row_4[2] = row_5[2] = bin_3
        puts "#{row_1}"
        puts "#{row_2}"
        puts "#{row_3}"
        puts "#{row_4}"
        puts "#{row_5}"
        bin_3 += 1
      end
      bin_2 += 1
    end
    bin_1 += 1
  end
end
def shannon_values
  #
end
<<cns_parameters
This is for the parameters that will be required in CNS
cns_parameters
@pdb_base_name = '5ao5' # don't include '.pdb'
extract_atoms
cns_generate_file
cns_run_generate
cns_expand_file(40, 163, 190,511)
# need to assign th rigid bodies in the style:
# {===>} atom_rigid_1=(segid A and resid 140:262);
# etc
#cns_run_expand
<<comments
input data file
scatter_file = File.open('file.file', 'w+')
comments
# input Dmax from real space
################
dmax = 100     #
################
# input Rg from real space
################
rg = 20        #
################
<<comment
here you need to specify how many Shannon channel you require.
the number is 3, 4, or 5. 5 should be fine enough sampling in order to achieve a chi^2 close to 1
comment
####################
shannon_bins = 1 #
####################
<<shannon
SAXS cat calculating the overall values for the bins for making the CNS files
shannon
channel_width = dmax / shannon_bins
index = 0
bin_center_array = []
until index == (shannon_bins-1)
  bin_centers = (channel_width * 0.5) + (shannon_bins * index)
  bin_center_array.push(bin_centers)
  index += 1
end

# here the name of the files need to be put between the parenthesis
if shannon_bins == 3
  bins_3()
elsif shannon_bins == 4
  bins_4()
elsif shannon_bins == 5
  bins_5()
end