a,s,b = input("Введите операнды в формате 'первый операнд|операция|второй операнд':").split()

'''
определяем: была ли введена константа
'''
def pars(x):
    length=len(a)
    if length < 3:
        if a=="e":
            from math import e as x
            return x
        elif a=="pi":
            from math import pi as x
            return x
    return int(x)

if s=="+":
    print(str(a)+"+"+str(b)+"="+str('%.2f' % (pars(a)+pars(b))))
    #print(f"{a}+{b}={pars(a)+pars(b)}")
elif s=="-":
    print(str(a)+"-"+str(b)+"="+str('%.2f' % (pars(a)-pars(b))))
elif s=="*":
    print(str(a)+"*"+str(b)+"="+str('%.2f' % (pars(a)*pars(b))))
elif s=="/":
    print(str(a)+"/"+str(b)+"="+str('%.2f' % (pars(a)/pars(b))))
elif s=="%":
    print(str(a)+"%"+str(b)+"="+str('%.2f' % (pars(a)%pars(b))))
elif s=="**":
    print(str(a)+"**"+str(b)+"="+str('%.2f' % (pars(a)**pars(b))))
else:
    print("неверная операция")