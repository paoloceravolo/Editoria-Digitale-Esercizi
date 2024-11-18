import re

def modify_markdown(file_path, output_path, rules):
    """
    Modifica un file Markdown in base a espressioni regolari definite dall'utente.
    
    :param file_path: Percorso al file Markdown da modificare.
    :param output_path: Percorso per salvare il file modificato.
    :param rules: Lista di dizionari con le regole di modifica. Ogni regola deve avere:
                  - "pattern": L'espressione regolare da cercare.
                  - "replace": Il contenuto con cui sostituire il pattern (o None per rimuoverlo).
    """
    with open(file_path, "r", encoding="utf-8") as file:
        content = file.read()
    
    for rule in rules:
        pattern = rule.get("pattern")
        replace = rule.get("replace")
        content = re.sub(pattern, replace, content)
    
    with open(output_path, "w", encoding="utf-8") as file:
        file.write(content)
    print(f"File modificato salvato in '{output_path}'.")

# Regole di esempio
rules = [
    # Aggiungere un'interruzione di pagina prima di ogni intestazione di livello 2
    {
        "pattern": r"(## .+)",  # Intestazione di livello 2
        "replace": r"\n<div style=\"page-break-before:always\"></div>\n\1"  # Interruzione di pagina
    },
    # Rimuovere sequenze come \[[modifica] | [modifica sorgente]]
    {
        "pattern": r"\[Modifica\](.+)\n",  # Sequenza da rimuovere
        "replace": ""  # Vuoto per rimuoverlo
    }
]

# Percorsi ai file
input_file = "Archiviazione_documenti_cartacei-Regole_generiche.md"   # File Markdown di input
output_file = "output.md" # File Markdown modificato

# Esecuzione dello script
modify_markdown(input_file, output_file, rules)
