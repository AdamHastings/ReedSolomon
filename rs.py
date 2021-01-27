add_table = [
    [0, 1, 2, 3, 4, 5, 6, 7],
    [1, 0, 4, 7, 2, 6, 5, 3],
    [2, 4, 0, 5, 1, 3, 7, 6],
    [3, 7, 5, 0, 6, 2, 4, 1],
    [4, 2, 1, 6, 0, 7, 3, 5],
    [5, 6, 3, 2, 7, 0, 1, 4],
    [6, 5, 7, 4, 3, 1, 0, 2],
    [7, 3, 6, 1, 5, 4, 2, 0],
]

symbol_table = [
    [0, 0, 0],  # 0
    [1, 0, 0],  # a^0
    [0, 1, 0],  # a^1
    [0, 0, 1],  # a^2
    [1, 1, 0],  # a^3
    [0, 1, 1],  # a^4
    [1, 1, 1],  # a^5
    [1, 0, 1],  # a^6
]


def get_index(symbol):
    for i in range(len(symbol_table)):
        if symbol_table[i] == symbol:
            return i


def add(a, b):
    symbol_a = symbol_table[a]
    symbol_b = symbol_table[b]
    xor = []
    for i in range(len(symbol_a)):
        xor.append(symbol_a[i] ^ symbol_b[i])
    return get_index(xor)


def multiply(a, b):
    # return (((a - 1) + (b - 1)) % 7) + 1
    # a = 6, b = 5 --> 5 + 4 = 9 % 7 = 2 + 1 = 3
    if (a == 0) or (b == 0):
        return 0
    # print("a:", a, "b:", b)
    return (((a - 1) + (b - 1)) % 7) + 1


def divide(a, b):
    diff = a - b
    if diff < 0:
        diff = diff % 7
    return diff + 1


def get_S(v, x):
    sum = 0
    l = len(v)
    for i in range(len(v)):
        prod = (((x - 1) * (l - i - 1)) % 7) + 1  # plug x in
        # print(" - in1 =", prod, ", in0 =", v[i])
        prod = multiply(v[i], prod)  # multiply x and v coefficient
        # print(" - S =", sum, ", mul_out =", prod)
        # print("prod", multiply(v[i], prod), mult_table[v[i]][prod])
        sum = add(sum, prod)
    return sum


def get_X1(S1, S2):
    # calculate S2/S1
    return divide(S2, S1)


def get_Y1(S1, S2):
    # calculate S1^2/S2
    S1_sq = multiply(S1, S1)
    print("s1 sq", S1_sq)
    return divide(S1_sq, S2)


def correct(v, X1, Y1):
    symbol_Y1 = symbol_table[Y1]
    print("error", v[len(v) - X1])
    symbol_error = symbol_table[v[len(v) - X1]]
    print("symbol error", symbol_error)
    xor = [a ^ b for a in symbol_Y1 for b in symbol_error]
    # print(xor)
    xor = []
    for i in range(len(symbol_Y1)):
        xor.append(symbol_Y1[i] ^ symbol_error[i])
    print(get_index(xor))
    v[len(v) - X1] = get_index(xor)
    return v


# def get_generator(t):

# Generator
# g(x) = (x-a)*(x-a^2)*(x-a^3)
# = (x^2 - x(a + a^2) + a^3) * (x-a^3)
# = (x^2 - xa^4 + a^3)*(x - a^3)
# = (x^3 - x^2a^4 + xa^3 - x^2a^3 + x - a^6)
# = (x^3 - x^2a^4 + xa^3 - x^2a^3 + x - a^6)
# = x^3 - x^2(a^4 + a^3) + x(a^3 + a^0) - a^6
# = x^3 - a^6x^2  + x - a^6
# = a^6 + x + a^6x^2 + x^3


def encode(m, k):
    shift_regs = [0, 0]
    gen = [4, 5]

    for i in range(len(m)):
        # if (i < len(m)):
        #     input = m[i]
        shift_regs[0] = multiply(add(m[i], shift_regs[1]), gen[0])
        shift_regs[1] = add(shift_regs[0], multiply(m[i], gen[1]))
        print(shift_regs)

    result = []
    result.append(shift_regs[1])
    temp = shift_regs[0]
    shift_regs[0] = multiply(add(0, shift_regs[1]), gen[0])
    print(shift_regs[0])
    shift_regs[1] = add(temp, multiply(shift_regs[1], gen[1]))
    result.append(shift_regs[1])

    print(result)
    return result


if __name__ == "__main__":
    m = [0, 1, 6, 3, 3]
    # encode(m, 7)
    v = [0, 0, 2, 6, 3, 1, 3]
    #v = [0, 1, 6, 3, 1, 7, 4]
    # v = [0, 1, 6, 3, 5, 7, 4]
    # print(v)
    S1 = get_S(v, 2)
    print("S1 =", S1)
    S2 = get_S(v, 3)
    print("S2 =", S2)
    X1 = get_X1(S1, S2)
    print("X1 =", X1)
    Y1 = get_Y1(S1, S2)
    print("Y1 =", Y1)
    v = correct(v, X1, Y1)
    print(v)