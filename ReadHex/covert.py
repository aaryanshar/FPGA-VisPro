with open("sample_imge.hex", "r") as source_file, open("output.mif", "w") as mif_file:
    mif_file.write("DEPTH = 3000;\n")
    mif_file.write("WIDTH = 8;\n")
    mif_file.write("ADDRESS_RADIX = HEX;\n")
    mif_file.write("DATA_RADIX = HEX;\n")
    mif_file.write("CONTENT BEGIN\n")
    
    for address, line in enumerate(source_file):
        hex_value = line.strip()  # Assuming each line contains one hex value
        mif_file.write(f"{address:04X} : {hex_value};\n")
    
    mif_file.write("END;\n")
