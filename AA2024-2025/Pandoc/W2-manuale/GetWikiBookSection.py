import requests
from markdownify import markdownify as md

def get_wikibooks_section(title, section, language):
    """
    Scarica il contenuto di una specifica sezione di una pagina Wikibooks.
    """
    url = f"https://{language}.wikibooks.org/w/api.php"
    params = {
        "action": "parse",
        "page": title,
        "format": "json",
        "prop": "text",
        "section": section,  # Richiede direttamente la sezione
    }
    
    response = requests.get(url, params=params)
    if response.status_code == 200:
        data = response.json()
        if "parse" in data and "text" in data["parse"]:
            return data["parse"]["text"]["*"]  # Contenuto HTML della sezione
        else:
            print(f"Nessun contenuto trovato per la sezione {section}.")
            return None
    else:
        print(f"Errore nel download della pagina: {response.status_code}")
        return None

def convert_html_to_markdown(html_content):
    """
    Converte il contenuto HTML in formato Markdown.
    """
    markdown_content = md(html_content, heading_style="ATX")
    return markdown_content

def save_to_file(content, filename):
    """
    Salva il contenuto in un file di testo.
    """
    with open(filename, "w", encoding="utf-8") as file:
        file.write(content)
    print(f"Contenuto salvato in '{filename}'.")

# Esempio di utilizzo
page_title = "Python Programming"      # Titolo della pagina Wikibooks
section_number = 1                      # Numero della sezione (esempio: 1 per Introduzione)
language = "en"                         # Lingua della pagina

html_content = get_wikibooks_section(page_title, section_number, language)
if html_content:
    markdown_content = convert_html_to_markdown(html_content)
    print("Contenuto della sezione in Markdown:")
    print(markdown_content[:500])  # Mostra un'anteprima del contenuto
    page_name = page_title.replace("/", "-")
    save_to_file(markdown_content, f"{page_name}_section_{section_number}.md")