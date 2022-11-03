import Weapon as Weapon

class L_M_Aire(Weapon) :
    def __init__(self, range, ammunition):
        super(L_M_Aire, self).__init__(30, 40)

    def fire_at(self, x,y,z):
        assert isinstance(z == 0)
        super(L_M_Aire, self).fire_at()

class  L_M_AntiAire(Weapon) :
    def __init__(self, range ,ammunition ):
        super(L_M_AntiAire, self).__init__(40, 50)

    def fire_at(self, x,y,z):
        assert isinstance(z<=0)
        super(L_M_AntiAire, self).fire_at()

class L_Torpille(Weapon) :
    def __init__(self,range, ammunition):
        super(L_Torpille, self).__init__(20, 15)

    def fire_at(self, x,y,z):
        assert isinstance(z<= 0)
        super(L_Torpille, self).fire_at()



        