#classe bateaux
class vaisseaux:
    #constructeur de la classe vaisseaux
    def __init__(self, coordonnée_x, coordonnée_y,coordonnée_z, weapon,max_hits):
        self.coordonnée_x = coordonnée_x
        self.coordonnée_y = coordonnée_y
        self.coordonnée_z = coordonnée_z
        self.weapon = weapon
        self.max_hits= max_hits
    def go_to(self,x,y,z):
        self
    def get_coordinates(self,x,y,z):
        self.x=x
    def fire_at(self,x,y,z):
 
#Classe Cruiser héritant de la classe vaisseaux
class Cruiser(vaisseaux):
     
    def __init__(self, coordonnée_x, coordonnée_y, weapon):
        super().__init__(coordonnée_x, coordonnée_y, weapon,)        
        self.max_hits =6
        self.coordonnée_z= 0
 
##Classe Submarine héritant de la classe vaisseaux
class Submarine(vaisseaux):
     
    
    def __init__(self, coordonnée_x, coordonnée_y, weapon):
        super().__init__(coordonnée_x, coordonnée_y, weapon,)        
        self.max_hits =2
        self.coordonnée_z= -1
 
##Classe Fregate héritant de la classe vaisseaux
class Fregate(vaisseaux):
     
    
    def __init__(self, coordonnée_x, coordonnée_y, weapon):
        super().__init__(coordonnée_x, coordonnée_y, weapon,)        
        self.max_hits =5
        self.coordonnée_z= 0
##Classe Destroyer héritant de la classe vaisseaux
class Destroyer(vaisseaux):
     
    
    def __init__(self, coordonnée_x, coordonnée_y, weapon):
        super().__init__(coordonnée_x, coordonnée_y, weapon,)        
        self.max_hits =4
        self.coordonnée_z= 0
##Classe Aircraft héritant de la classe vaisseaux
class Aircraft(vaisseaux):
    
    def __init__(self, coordonnée_x, coordonnée_y, weapon):
        super().__init__(coordonnée_x, coordonnée_y, weapon,)        
        self.max_hits =1
        self.coordonnée_z= 1
      
   #Accesseur get pour récupérer le nom
    def _get_nom(self):
         
        print("On accède au nom du bateau de la classe sous-marin")
        return self.nom