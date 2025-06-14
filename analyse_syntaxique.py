import sys
from sly import Parser
from analyse_lexicale import FloLexer
import arbre_abstrait

class FloParser(Parser):
    
    tokens = FloLexer.tokens

    



    @_('listeInstructions')
    def prog(self, p):
        return arbre_abstrait.Programme(p.listeInstructions)

    @_('instruction')
    def listeInstructions(self, p):
        l = arbre_abstrait.ListeInstructions()
        l.instructions.append(p[0])
        return l
                    
    @_('instruction listeInstructions')
    def listeInstructions(self, p):
        p[1].instructions.insert(0,p[0])
        return p[1]
        
    @_('ecrire')
    def instruction(self, p):
        return p[0]
            
    @_('ECRIRE "(" expr ")" ";"')
    def ecrire(self, p):
        return arbre_abstrait.Ecrire(p.expr) 
    
    @_('booleen')
    def expr(self, p):
        return p.booleen

    
    @_('ouLogique')
    def booleen(self, p):
        return p.ouLogique

    
    @_('etLogique')
    def ouLogique(self, p):
        return p.etLogique

    @_('ouLogique OU etLogique')
    def ouLogique(self, p):
        return arbre_abstrait.Operation('ou', p.ouLogique, p.etLogique)

    
    @_('negation')
    def etLogique(self, p):
        return p.negation

    @_('etLogique ET negation')
    def etLogique(self, p):
        return arbre_abstrait.Operation('et', p.etLogique, p.negation)

    
    @_('comparaison')
    def negation(self, p):
        return p.comparaison

    @_('somme')
    def comparaison(self, p):
        return p.somme


    @_('NON negation')
    def negation(self, p):
        return arbre_abstrait.Operation('non', p.negation, None)


    @_('somme EGAL somme')
    def comparaison(self, p):
        return arbre_abstrait.Operation('==', p[0], p[2])

    @_('somme DIFFERENT somme')
    def comparaison(self, p):
        return arbre_abstrait.Operation('!=', p[0], p[2])

    @_('somme INFERIEUR somme')
    def comparaison(self, p):
        return arbre_abstrait.Operation('<', p[0], p[2])

    @_('somme INFERIEUR_OU_EGAL somme')
    def comparaison(self, p):
        return arbre_abstrait.Operation('<=', p[0], p[2])

    @_('somme SUPERIEUR somme')
    def comparaison(self, p):
        return arbre_abstrait.Operation('>', p[0], p[2])

    @_('somme SUPERIEUR_OU_EGAL somme')
    def comparaison(self, p):
        return arbre_abstrait.Operation('>=', p[0], p[2])
    
    @_('somme "+" produit')
    def somme(self, p):
        return arbre_abstrait.Operation('+', p[0], p[2])

    @_('somme "-" produit')
    def somme(self, p):
        return arbre_abstrait.Operation('-', p[0], p[2])

    @_('produit')
    def somme(self, p):
        return p.produit

    @_('produit "*" facteur')
    def produit(self, p):
        return arbre_abstrait.Operation(p[1], p[0], p[2])

    @_('produit "/" facteur')
    def produit(self, p):
        return arbre_abstrait.Operation('/', p[0], p[2])

    @_('produit "%" facteur')
    def produit(self, p):
        return arbre_abstrait.Operation('%', p[0], p[2])

    @_('facteur')
    def argument(self, p):
        return p.facteur

    @_('argument')
    def listeArguments(self, p):
        return [p.argument]

    @_('argument "," listeArguments')
    def listeArguments(self, p):
        return [p.argument] + p.listeArguments

    @_('facteur')
    def produit(self, p):
        return p.facteur

    @_('IDENTIFIANT')
    def facteur(self, p):
        return arbre_abstrait.Variable(p.IDENTIFIANT)

    @_('LIRE "(" ")"')
    def facteur(self, p):
        return arbre_abstrait.Lire()

    @_('IDENTIFIANT "(" listeArguments ")" ";"')
    def instruction(self, p):
        return arbre_abstrait.AppelFonctionInstruction(p.IDENTIFIANT, p.listeArguments)
    
    @_('IDENTIFIANT "(" listeArguments ")"')
    def facteur(self, p):
        return arbre_abstrait.AppelFonction(p.IDENTIFIANT, p.listeArguments)

    @_('IDENTIFIANT AFFECTATION expr ";"')
    def instruction(self, p):
        return arbre_abstrait.Affectation(p.IDENTIFIANT, p.expr)

    @_('TYPE IDENTIFIANT ";"')
    def instruction(self,p):
        return arbre_abstrait.Declaration(p.TYPE, p.IDENTIFIANT)
    
    @_('TYPE IDENTIFIANT AFFECTATION expr ";"')
    def instruction(self,p):
        return arbre_abstrait.DeclarationAffectation(p.TYPE, p.IDENTIFIANT, p.expr)

    @_('SI "(" expr ")" "{" listeInstructions "}" liste_elif_else')
    def instruction(self, p):
        si_node = arbre_abstrait.Si(p.expr, p.listeInstructions)
        si_node.corps_sinon_si = p.liste_elif_else[0]
        si_node.corps_sinon = p.liste_elif_else[1]
        return si_node
    
    @_('TANTQUE "(" expr ")" "{" listeInstructions "}"')
    def instruction(self, p):
        return arbre_abstrait.Tantque(p.expr, p.listeInstructions)

    @_('RETOURNER expr ";"')
    def instruction(self, p):
        return arbre_abstrait.Retourner(p.expr)


    @_('liste_elif else_block')
    def liste_elif_else(self, p):
        return (p.liste_elif, p.else_block)

    @_('liste_elif')
    def liste_elif_else(self, p):
        return (p.liste_elif, None)

    @_('else_block')
    def liste_elif_else(self, p):
        return ([], p.else_block)

    @_('')
    def liste_elif_else(self, p):
        return ([], None)

    @_('elif_block')
    def liste_elif(self, p):
        return [p.elif_block]

    @_('liste_elif elif_block')
    def liste_elif(self, p):
        p.liste_elif.append(p.elif_block)
        return p.liste_elif



    @_('SINON_SI "(" expr ")" "{" listeInstructions "}"')
    def elif_block(self, p):
        return arbre_abstrait.Elif(p.expr, p.listeInstructions)

    @_('SINON "{" listeInstructions "}"')
    def else_block(self, p):
        return arbre_abstrait.Else(p.listeInstructions)

    @_('"(" expr ")"')
    def facteur(self, p):
        return p.expr

    @_('"-" facteur')
    def facteur(self, p):
        return arbre_abstrait.Operation('-', arbre_abstrait.Entier(0), p[1])
    
    @_('TYPE_ENTIER')
    def TYPE(self, p):
        return 'entier'

    @_('TYPE_BOOLEEN')
    def TYPE(self, p):
        return 'booleen'
        
    @_('ENTIER')
    def facteur(self, p):
        return arbre_abstrait.Entier(p.ENTIER) 
    
    @_('BOOLEEN')
    def facteur(self, p):
        return arbre_abstrait.Booleen(p.BOOLEEN)

        
    def error(self, p):
        print('Erreur de syntaxe',p,file=sys.stderr)
        exit(1)

if __name__ == '__main__':
    lexer = FloLexer()
    parser = FloParser()
    if len(sys.argv) < 2:
        print("usage: python3 analyse_syntaxique.py NOM_FICHIER_SOURCE.flo")
    else:
        with open(sys.argv[1],"r") as f:
            data = f.read()
            try:
                arbre = parser.parse(lexer.tokenize(data))
                arbre.afficher()
            except EOFError:
                exit(1)
