import requests
from bs4 import BeautifulSoup

def get_wikipedia_metadata(title, language):
    """
    Scarica i metadati (infobox o moduli) di una pagina Wikipedia.
    """
    url = f"https://{language}.wikipedia.org/w/api.php"
    params = {
        "action": "parse",
        "page": title,
        "format": "json",
        "prop": "text",
    }

    response = requests.get(url, params=params)
    if response.status_code == 200:
        data = response.json()
        if "parse" in data and "text" in data["parse"]:
            return data["parse"]["text"]["*"]  # Contenuto HTML della pagina
        else:
            print(f"Nessun contenuto trovato per la pagina '{title}'.")
            return None
    else:
        print(f"Errore nel download della pagina: {response.status_code}")
        return None
    
def sanitize_key(key):
    """
    Sostituisce gli spazi nei nomi delle chiavi con underscore (_).
    """
    return key.replace(" ", "_")

def extract_code_from_metadata(html_content,tab_class):
    """
    Analizza il contenuto HTML per estrarre codice da Infobox o template.
    """
    soup = BeautifulSoup(html_content, "html.parser")
    
    # Cerca blocchi di codice o preformattati
    metadata_blocks = soup.find_all("table", class_=tab_class)

    metadata = []
    
    # Analizza l'Infobox per possibili dati strutturati
    for table in metadata_blocks:
        rows = table.find_all("tr")
        for row in rows:
            if row.th and row.td:
                key = row.th.get_text(strip=True)
                sanitized_key = sanitize_key(key)  # Rende i nomi delle chiavi compatibili
                value = row.td.get_text(strip=True)
                metadata.append(f"{sanitized_key}: {value}")

    return metadata

def save_metadata_to_file(metadata, filename):
    """
    Salva i frammenti di codice in un file di testo.
    """
    with open(filename, "w", encoding="utf-8") as file:
        for entry in metadata:
            file.write(entry + "\n\n")
    print(f"Metadati salvati in '{filename}'.")

# Esempio di utilizzo
page_title = "Copyright"  # Titolo della pagina
language = "it"          # Lingua
tab_class = "CdA" # Tabelle di metadati da estrarre da Wikiemida. Es: inforbox, navbox, CdA, informazioni-file, imbox-licence

html_content = get_wikipedia_metadata(page_title, language)
if html_content:
    metadata = extract_code_from_metadata(html_content,tab_class)
    print("Metadati trovati:")
    for entry in metadata:
        print(metadata[:100])  # Anteprima metadati (prima di salvare)
    save_metadata_to_file(metadata, f"{page_title}_metadata.yaml")