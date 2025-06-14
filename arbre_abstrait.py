"""
Affiche une chaine de caractère avec une certaine identation
"""
def afficher(s,indent=0):
    print(" "*indent+s)
    
class Programme:
    def __init__(self, listeInstructions):
        self.listeInstructions = listeInstructions
    def afficher(self,indent=0):
        afficher("<programme>",indent)
        self.listeInstructions.afficher(indent+1)
        afficher("</programme>",indent)

class ListeInstructions:
    def __init__(self):
        self.instructions = []
    def afficher(self,indent=0):
        afficher("<listeInstructions>",indent)
        for instruction in self.instructions:
            instruction.afficher(indent+1)
        afficher("</listeInstructions>",indent)
            
class Ecrire:
    def __init__(self,exp):
        self.exp = exp
    def afficher(self,indent=0):
        afficher("<ecrire>",indent)
        self.exp.afficher(indent+1)
        afficher("</ecrire>",indent)
        
class Operation:
    def __init__(self,op,exp1,exp2=None):
        self.exp1 = exp1
        self.op = op
        self.exp2 = exp2
        self.type = None
    def afficher(self,indent=0):
        afficher(f'<operation "{self.op}">',indent)
        self.exp1.afficher(indent+1)
        if self.exp2 is not None:
            self.exp2.afficher(indent+1)
        afficher("</operation>",indent)
class Entier:
    def __init__(self,valeur):
        self.valeur = valeur
        self.type = "entier"
    def afficher(self,indent=0):
        afficher("[Entier:"+str(self.valeur)+"]",indent)
class Booleen:
    def __init__(self,valeur):
        self.valeur = valeur
        self.type = "booleen"
    def afficher(self,indent=0):
        afficher("[Booleen:"+str(self.valeur)+"]",indent)

class Declaration:
    def __init__(self,type_variable,nom):
        self.type_variable = type_variable
        self.nom = nom
    def afficher(self, indent=0):
        afficher(f"[Declaration: Type={self.type_variable}, Nom={self.nom}]", indent)
class Variable:
    def __init__(self, nom):
        self.nom = nom
    def afficher(self, indent=0):
        afficher(f"[Variable: {self.nom}]", indent)

class Lire:
    def afficher(self, indent=0):
        afficher("<lire/>", indent)

class AppelFonction:
    def __init__(self, nom, args):
        self.nom = nom
        self.args = args
    def afficher(self, indent=0):
        afficher(f"<appel-fonction {self.nom}>", indent)
        for arg in self.args:
            arg.afficher(indent + 1)
        afficher(f"</appel-fonction {self.nom}>", indent)
class Affectation:
    def __init__(self, ident, expr):
        self.ident = ident
        self.expr = expr

    def afficher(self, indent=0):
        print("  " * indent + f"Affectation({self.ident})")
        self.expr.afficher(indent + 1)
class DeclarationAffectation:
    def __init__(self, type_variable, nom_variable, expression):
        self.type_variable = type_variable
        self.nom_variable = nom_variable
        self.expression = expression

    def afficher(self, indent=0):
        afficher(f"[DeclarationAffectation: Type={self.type_variable}, Nom={self.nom_variable}]", indent)
        afficher("Expression:", indent + 1)
        self.expression.afficher(indent + 2)
class Si:
    def __init__(self, condition, corps_si):
        self.condition = condition
        self.corps_si = corps_si
        self.corps_sinon_si = [] 
        self.corps_sinon = None

    def afficher(self, indent=0):
        afficher("[Instruction SI]", indent)
        afficher("Condition:", indent + 1)
        self.condition.afficher(indent + 2) 
        afficher("Corps SI:", indent + 1)
        self.corps_si.afficher(indent + 2)
        for elif_block in self.corps_sinon_si:
            elif_block.afficher(indent)
        if self.corps_sinon:
            self.corps_sinon.afficher(indent)
class Elif:
    def __init__(self, condition, corps_elif):
        self.condition = condition
        self.corps_elif = corps_elif

    def afficher(self, indent=0):
        afficher("[Instruction SINON_SI]", indent)
        afficher("Condition:", indent + 1)
        self.condition.afficher(indent + 2)
        afficher("Corps SINON_SI:", indent + 1)
        self.corps_elif.afficher(indent + 2)
class Else:
    def __init__(self, corps_else):
        self.corps_else = corps_else

    def afficher(self, indent=0):
        afficher("[Instruction SINON]", indent)
        afficher("Corps SINON:", indent + 1)
        self.corps_else.afficher(indent + 2)
class Tantque:
    def __init__(self, condition, bloc):
        self.condition = condition
        self.bloc = bloc

    def afficher(self, indentation=0):
        print('  '*indentation + "<tantque>")
        print('  '*(indentation+1) + "<condition>")
        self.condition.afficher(indentation+2)
        print('  '*(indentation+1) + "</condition>")
        self.bloc.afficher(indentation+1)
        print('  '*indentation + "</tantque>")
class Retourner:
    def __init__(self, valeur):
        self.valeur = valeur

    def afficher(self, indentation=0):
        print('  '*indentation + "<retourner>")
        self.valeur.afficher(indentation+1)
        print('  '*indentation + "</retourner>")
class AppelFonctionInstruction:
    def __init__(self, nom, arguments):
        self.nom = nom
        self.arguments = arguments

    def afficher(self, indentation=0):
        print('  '*indentation + f"<appelFonctionInstruction: {self.nom}>")
        for arg in self.arguments:
            arg.afficher(indentation+1)
        print('  '*indentation + f"</appelFonctionInstruction: {self.nom}>")
