import sys
from analyse_lexicale import FloLexer
from analyse_syntaxique import FloParser
import arbre_abstrait
from table_symboles import TableSymboles  # NOUVEAU: Import de la table des symboles

num_etiquette_courante = -1 #Permet de donner des noms différents à toutes les étiquettes (en les appelant e0, e1,e2,...)

afficher_table = False
afficher_code = False

# NOUVEAU: Variable globale pour la table des symboles
table_symboles = TableSymboles()

"""
affiche une erreur sur la sortie stderr et quitte le programme
"""

def erreur(s):
    print("Erreur:",s,file=sys.stderr)
    exit(1)
    
"""
Un print qui ne fonctionne que si la variable afficher_table vaut Vrai.
(permet de choisir si on affiche le code assembleur ou la table des symboles)
"""
def printifm(*args,**kwargs):
    if afficher_code:
        print(*args,**kwargs)

"""
Un print qui ne fonctionne que si la variable afficher_table vaut Vrai.
(permet de choisir si on affiche le code assembleur ou la table des symboles)
"""
def printift(*args,**kwargs):
    if afficher_table:
        print(*args,**kwargs)

"""
Fonction locale, permet d'afficher un commentaire dans le code arm.
"""
def arm_comment(comment):
    if comment != "":
        printifm("\t\t @ "+comment)#le point virgule indique le début d'un commentaire en ARM. Les tabulations sont là pour faire jolie.
    else:
        printifm("")  
"""
Affiche une instruction ARM sur une ligne
Par convention, les derniers opérandes sont nuls si l'opération a moins de 3 arguments.
"""
def arm_instruction(opcode, op1="", op2="", op3="", comment=""):
    if op2 == "":
        printifm("\t"+opcode+"\t"+op1+"\t\t",end="")
    elif op3 =="":
        printifm("\t"+opcode+"\t"+op1+",\t"+op2+"\t",end="")
    else:
        printifm("\t"+opcode+"\t"+op1+",\t"+op2+",\t"+op3,end="")
    arm_comment(comment)


"""
Retourne le nom d'une nouvelle étiquette
"""
def arm_nouvelle_etiquette():
    global num_etiquette_courante
    num_etiquette_courante+=1
    return "e"+str(num_etiquette_courante)

"""
Affiche le code arm correspondant à tout un programme
"""
def gen_programme(programme):
    header=""".global __aeabi_idiv
    .global __aeabi_idivmod
.LC0:
    .ascii	"%d\\000"
    .align	2
.LC1:
    .ascii	"%d\\012\\000"
    .text
    .align	2
    .global	main"""
    printifm(header)
    
    # NOUVEAU: Initialiser la table des symboles pour le programme principal
    table_symboles.entrer_bloc()  # Bloc principal
    
    printifm('main:')
    arm_instruction("push", "{fp,lr}", "", "", "")
    arm_instruction("add", "fp","sp", "#4", "")
    gen_listeInstructions(programme.listeInstructions)
    
    # NOUVEAU: Libérer les variables locales du programme principal
    arm_instruction("sub", "sp", "fp", "#4", "libérer variables locales")
    
    arm_instruction("mov", "r0", "#0", "", "")
    arm_instruction("pop", "{fp, pc}","","","")

"""
Affiche le code arm correspondant à une suite d'instructions
"""
def gen_listeInstructions(listeInstructions):
    for instruction in listeInstructions.instructions:
        gen_instruction(instruction)

"""
Affiche le code arm correspondant à une instruction
"""
def gen_instruction(instruction):
    if type(instruction) == arbre_abstrait.Ecrire:
        gen_ecrire(instruction)
    elif type(instruction) == arbre_abstrait.Tantque: 
        gen_tantque(instruction)
    elif type(instruction) == arbre_abstrait.Si:  
        gen_si(instruction)
    elif type(instruction) == arbre_abstrait.Affectation: 
        gen_affectation(instruction)
    elif type(instruction) == arbre_abstrait.Declaration:  
        gen_declaration(instruction)
    elif type(instruction) == arbre_abstrait.DeclarationAffectation:
        gen_declarationAffectation(instruction)
    else:
        erreur("génération type instruction non implémenté "+str(type(instruction)))

"""
Affiche le code arm correspondant au fait d'envoyer la valeur entière d'une expression sur la sortie standard
"""	
def gen_declarationAffectation(decl):
    # NOUVEAU: Ajouter la variable à la table des symboles
    try:
        table_symboles.ajouter_variable(decl.nom_variable, decl.type_variable)
    except ValueError as e:
        erreur(str(e))
    
    # Générer le code pour l'expression
    type_expr = gen_expression(decl.expression)
    
    # NOUVEAU: Vérification de type
    if type_expr != decl.type_variable:
        erreur(f"Erreur de type : impossible d'affecter {type_expr} à {decl.type_variable}")
    
    # Stocker la valeur
    arm_instruction("pop", "{r0}", "", "", "valeur de l'expression")
    var_info = table_symboles.obtenir_variable(decl.nom_variable)
    arm_instruction("str", "r0", f"[fp, #{var_info['adresse']}]", "", f"stocker dans {decl.nom_variable}")

def gen_declaration(decl):
    # NOUVEAU: Ajouter la variable à la table des symboles
    try:
        table_symboles.ajouter_variable(decl.nom, decl.type_variable)
    except ValueError as e:
        erreur(str(e))
    
    # Réserver l'espace mémoire
    arm_instruction("sub", "sp", "sp", "#4", f"réserver 4 octets pour {decl.nom}")
    
    # NOUVEAU: Initialiser avec valeur par défaut
    if decl.type_variable == "entier":
        arm_instruction("mov", "r0", "#0", "", "valeur par défaut entier")
    else:  # booleen
        arm_instruction("mov", "r0", "#0", "", "valeur par défaut booleen (Faux)")
    
    var_info = table_symboles.obtenir_variable(decl.nom)
    arm_instruction("str", "r0", f"[fp, #{var_info['adresse']}]", "", f"initialiser {decl.nom}")

def gen_affectation(affect):
    # NOUVEAU: Vérifier que la variable existe
    try:
        var_info = table_symboles.obtenir_variable(affect.ident)
    except ValueError as e:
        erreur(str(e))
    
    # Générer l'expression
    type_expr = gen_expression(affect.expr)
    
    # NOUVEAU: Vérification de type
    if type_expr != var_info['type']:
        erreur(f"Erreur de type : impossible d'affecter {type_expr} à {var_info['type']}")
    
    # Affecter la valeur
    arm_instruction("pop", "{r0}", "", "", "valeur à affecter")
    arm_instruction("str", "r0", f"[fp, #{var_info['adresse']}]", "", f"affecter à {affect.ident}")

def gen_ecrire(ecrire):
    gen_expression(ecrire.exp) #on calcule et empile la valeur d'expression
    arm_instruction("pop", "{r1}", "", "", "") #on dépile la valeur d'expression sur r1
    arm_instruction("ldr", "r0", "=.LC1", "", "")
    arm_instruction("bl", "printf", "", "", "") #on envoie la valeur de r1 sur la sortie standard

def gen_tantque(tantque):
    etiq_debut = arm_nouvelle_etiquette()
    etiq_fin = arm_nouvelle_etiquette()
    
    # NOUVEAU: Entrer dans le bloc de la boucle
    table_symboles.entrer_bloc()
    
    printifm(etiq_debut + ":")
    
    # Générer et vérifier la condition
    type_condition = gen_expression(tantque.condition)
    # NOUVEAU: Vérifier que la condition est un booléen
    if type_condition != "booléen":
        erreur("Erreur de type : la condition d'une boucle doit être un booléen")
    
    arm_instruction("pop", "{r1}", "", "", "dépile la condition")
    arm_instruction("cmp", "r1", "#0", "", "teste si condition == 0 (faux)")
    arm_instruction("beq", etiq_fin, "", "", "saut si condition fausse")
    
    gen_listeInstructions(tantque.bloc)
    
    arm_instruction("b", etiq_debut, "", "", "retour au début de la boucle")
    printifm(etiq_fin + ":")
    
    # NOUVEAU: Sortir du bloc de la boucle
    table_symboles.sortir_bloc()

def gen_si(si):
    etiq_fin = arm_nouvelle_etiquette()
    etiq_sinon = arm_nouvelle_etiquette()
    
    # Générer et vérifier la condition
    type_condition = gen_expression(si.condition)
    # NOUVEAU: Vérifier que la condition est un booléen
    if type_condition != "booléen":
        erreur("Erreur de type : la condition d'un si doit être un booléen")
    
    arm_instruction("pop", "{r1}", "", "", "dépile la condition")
    arm_instruction("cmp", "r1", "#0", "", "teste si condition == 0 (faux)")
    arm_instruction("beq", etiq_sinon, "", "", "saut si condition fausse")
    
    # NOUVEAU: Entrer dans le bloc du si
    table_symboles.entrer_bloc()
    gen_listeInstructions(si.corps_si)
    table_symboles.sortir_bloc()
    
    arm_instruction("b", etiq_fin, "", "", "saut vers la fin")
    printifm(etiq_sinon + ":")
    
    # Gérer les elif
    if si.corps_sinon_si:
        for elif_block in si.corps_sinon_si:
            gen_elif(elif_block, etiq_fin)
    
    # Gérer le else
    if si.corps_sinon:
        # NOUVEAU: Entrer dans le bloc du else
        table_symboles.entrer_bloc()
        gen_listeInstructions(si.corps_sinon.corps_else)
        table_symboles.sortir_bloc()
    
    printifm(etiq_fin + ":")

def gen_elif(elif_block, etiq_fin):
    etiq_next = arm_nouvelle_etiquette()
    
    # Générer et vérifier la condition
    type_condition = gen_expression(elif_block.condition)
    # NOUVEAU: Vérifier que la condition est un booléen
    if type_condition != "booléen":
        erreur("Erreur de type : la condition d'un sinon si doit être un booléen")
    
    arm_instruction("pop", "{r1}", "", "", "dépile la condition")
    arm_instruction("cmp", "r1", "#0", "", "teste si condition == 0 (faux)")
    arm_instruction("beq", etiq_next, "", "", "saut si condition fausse")
    
    # NOUVEAU: Entrer dans le bloc du elif
    table_symboles.entrer_bloc()
    gen_listeInstructions(elif_block.corps_elif)
    table_symboles.sortir_bloc()
    
    arm_instruction("b", etiq_fin, "", "", "saut vers la fin")
    printifm(etiq_next + ":")

def gen_lire(lire):
    arm_instruction("ldr", "r0", "=.LC0", "", "adresse du format %d")
    arm_instruction("sub", "sp", "sp", "#4", "réserver 4 octets sur la pile")
    arm_instruction("mov", "r1", "sp", "", "adresse où stocker l'entier lu")
    arm_instruction("bl", "scanf", "", "", "appel à scanf")
    arm_instruction("ldr", "r0", "[sp]", "", "charger l'entier lu")
    arm_instruction("add", "sp", "sp", "#4", "libérer la pile")
    arm_instruction("push", "{r0}", "", "", "empiler la valeur lue")

"""
Affiche le code arm pour calculer et empiler la valeur d'une expression
"""
def gen_expression(expression):
    if type(expression) == arbre_abstrait.Operation:
        return gen_operation(expression) 
    elif type(expression) == arbre_abstrait.Entier:
        arm_instruction("mov", "r1", "#"+str(expression.valeur), "", "") 
        arm_instruction("push", "{r1}", "", "", "")
        return "entier"
    elif type(expression) == arbre_abstrait.Booleen:
        valeur = 1 if expression.valeur else 0
        arm_instruction("mov", "r1", "#"+str(valeur), "", "")
        arm_instruction("push", "{r1}", "", "", "")
        return "booléen"
    elif type(expression) == arbre_abstrait.Lire:
        gen_lire(expression)
        return "entier"
    elif type(expression) == arbre_abstrait.Variable:
        # NOUVEAU: Gérer les variables
        try:
            var_info = table_symboles.obtenir_variable(expression.nom)
        except ValueError as e:
            erreur(str(e))
        
        arm_instruction("ldr", "r0", f"[fp, #{var_info['adresse']}]", "", f"charger {expression.nom}")
        arm_instruction("push", "{r0}", "", "", "")
        return var_info['type']
    else:
        erreur("type d'expression inconnu"+str(type(expression)))


"""
Affiche le code arm pour calculer l'opération et la mettre en haut de la pile
"""
def gen_operation(operation):
    op = operation.op

    # --- Unary 'non' handling (remains the same) ---
    if op == 'non':
        type1 = gen_expression(operation.exp1)
        if type1 != "booléen":
            erreur(f"Erreur de type : opérateur logique 'non' appliqué à un non-booléen")
        arm_instruction("pop", "{r0}", "", "", "dépile exp1 dans r0")
        arm_instruction("cmp", "r0", "#0", "", "compare à 0")
        arm_instruction("moveq", "r0", "#1", "", "si égal à 0 -> 1")
        arm_instruction("movne", "r0", "#0", "", "sinon -> 0")
        arm_instruction("push", "{r0}", "", "", "empile le résultat")
        operation.type = "booléen"
        return "booléen" # Important to return here for unary ops

    # --- Binary operations ---
    # Generate code for both expressions first
    type1 = gen_expression(operation.exp1)
    type2 = gen_expression(operation.exp2) # Assumes exp2 is always present for binary ops

    # Dépile les valeurs des deux opérandes dans r0 et r1
    arm_instruction("pop", "{r1}", "", "", "dépile exp2 dans r1")
    arm_instruction("pop", "{r0}", "", "", "dépile exp1 dans r0")

    # --- Type checking and ARM generation based on operator type ---
    if op in ['+', '-', '*', '/', '%']:
        if type1 != "entier" or type2 != "entier":
            erreur(f"Erreur de type : opérateur arithmétique '{op}' appliqué à des non-entiers")
        operation.type = "entier" # Result is an integer
        # ARM generation for arithmetic ops
        code = {"+":"add","*":"mul","-":"sub"}
        if op in ['+','-']:
            arm_instruction(code[op], "r0", "r0", "r1", "effectue l'opération r0" +op+"r1 et met le résultat dans r0" )
        elif op == '*':
    # Eviter Rd == Rm en utilisant r2 comme tampon
            arm_instruction("mov", "r2", "r0", "", "copie r0 dans r2")
            arm_instruction("mul", "r0", "r1", "r2", "r0 = r1 * r2")
        elif op == '/':
            arm_instruction("bl", "__aeabi_idiv", "", "", "division entière")
        elif op == '%':
            arm_instruction("bl", "__aeabi_idivmod", "", "", "appel à la division modulaire, reste dans r1")
            arm_instruction("mov", "r0", "r1", "", "copie le reste de r1 vers r0")

    elif op in ['==', '!=', '<', '>', '<=', '>=']: # Comparison operators
        if type1 != "entier" or type2 != "entier": # <--- THEY OPERATE ON INTEGERS
            erreur(f"Erreur de type : opérateur de comparaison '{op}' appliqué à des non-entiers")
        operation.type = "booléen" # <--- BUT PRODUCE A BOOLEAN RESULT
        # ARM generation for comparison ops (your existing code here)
        arm_instruction("cmp", "r0", "r1", "", "compare r0 et r1")
        etiq_vrai = arm_nouvelle_etiquette()
        etiq_fin = arm_nouvelle_etiquette()
        saut = {
            "==": "beq",
            "!=": "bne",
            "<":  "blt",
            ">":  "bgt",
            "<=": "ble",
            ">=": "bge"
        }
        arm_instruction(saut[op], etiq_vrai, "", "", f"saut si {op} est vrai")
        arm_instruction("mov", "r0", "#0", "", "résultat faux")
        arm_instruction("b", etiq_fin, "", "", "saut vers fin")
        printifm(etiq_vrai + ":")
        arm_instruction("mov", "r0", "#1", "", "résultat vrai")
        printifm(etiq_fin + ":")

    elif op in ['et', 'ou']: # Logical operators
        if type1 != "booléen" or type2 != "booléen":
            erreur(f"Erreur de type : opérateur logique '{op}' appliqué à des non-booléens")
        operation.type = "booléen" # Result is a boolean
        # ARM generation for logical ops
        if op == 'et':
            arm_instruction("mul", "r0", "r0", "r1", "et booléen = multiplication") # Simpler for boolean AND (0*0=0, 0*1=0, 1*0=0, 1*1=1)
        elif op == 'ou':
            arm_instruction("add", "r0", "r0", "r1", "ou logique: r0 + r1")
            arm_instruction("cmp", "r0", "#2", "", "compare avec 2")
            etiq_fin_ou = arm_nouvelle_etiquette()
            arm_instruction("blt", etiq_fin_ou, "", "", "saut si < 2")
            arm_instruction("mov", "r0", "#1", "", "si >= 2, mettre 1")
            printifm(etiq_fin_ou + ":")

    else:
        erreur("operateur \""+op+"\" non implémenté")

    arm_instruction("push",  "{r0}" , "", "", "empile le résultat")
    return operation.type


if __name__ == "__main__":
    afficher_arm = True
    lexer = FloLexer()
    parser = FloParser()
    if len(sys.argv) < 3 or sys.argv[1] not in ["-arm","-table"]:
        print("usage: python3 generation_code.py -arm|-table NOM_FICHIER_SOURCE.flo")
        exit(1)
    if sys.argv[1]  == "-arm":
        afficher_code = True
    else:
        afficher_table = True
        # NOUVEAU: Si on veut afficher la table, on l'affiche à la fin
    with open(sys.argv[2],"r") as f:
        data = f.read()
        try:
            arbre = parser.parse(lexer.tokenize(data))
            gen_programme(arbre)
            # NOUVEAU: Afficher la table des symboles si demandé
            if afficher_table:
                table_symboles.afficher()
        except EOFError:
            exit(1)