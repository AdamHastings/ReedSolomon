text = open('255.txt', "r")
lines = text.readlines()

output = open("output.txt", "w")

for line in lines:
    tokens = line.split()
    if (tokens[0] == "-"):
        output.write("8'd0 : out <= 8'b00000000;\n")
    else:
        decimal = str(int(tokens[0]) + 1)
        binary = "" 
        for i in range(3,11):
            binary += tokens[i]
        output.write("8'b" + binary + " : out <= 8'd" + decimal + ";\n")

output.close()

