## Esercizio: Creazione di un manuale a partire da fonti aperte

**Obiettivo:** Utilizzare fonti aperte (ad esempio, [Wikipedia](https://it.wikipedia.org), [Wikibooks](https://en.wikibooks.org/), [OpenStax](https://openstax.org), [BookInProgress](https://www.bookinprogress.org)) per creare un manuale tecnico da distribuire come documento web, PDF e ePUB, oltre alla generazione del documento è importante produrre un set di metadati adatto a supportare diverse fasi: (i) gestione documentale, (ii) archiviazione, (iii) distribuzione.

1. **Reperimento del Documento Sorgente**

   - Scarica un file HTML, o XML se disponibile, da una fonte aperta, come una voce di Wikipedia o una sezione di un manuale aperto (ad esempio, da [Wikibooks](https://en.wikibooks.org/)).

     ```python
     import requests
     from markdownify import markdownify as md
     
     def get_wikibooks_page(title, language):
         """
         Scarica il contenuto completo di una pagina Wikibooks.
         """
         url = f"https://{language}.wikibooks.org/w/api.php"
         params = {
             "action": "parse",
             "page": title,
             "format": "json",
             "prop": "text|sections"
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
     page_title = "Archiviazione_documenti_cartacei/Regole_generiche"  # Titolo della pagina Wikibooks
     language = "it"                    # Lingua della pagina
     
     html_content = get_wikibooks_page(page_title, language)
     if html_content:
         markdown_content = convert_html_to_markdown(html_content)
         print("Contenuto della pagina in Markdown (anteprima):")
         print(markdown_content[:500])  # Mostra un'anteprima del contenuto
         page_name = page_title.replace("/", "-")
         save_to_file(markdown_content, f"{page_name}.md")
     ```

2. **Migliora il file Markdown** 

   - Rimuovi elementi non necessari.

   - Assicuarati che i titoli delle sezioni siano codificati come intestazioni (headings)

   - Aggiungi le interruzioni di pagina.

     ```python
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
     input_file = "input.md"   # File Markdown di input
     output_file = "output.md" # File Markdown modificato
     
     # Esecuzione dello script
     modify_markdown(input_file, output_file, rules)
     
     ```

     

3. **Estrazione di metadati**

   - Prova a sfruttare le sorgenti per estrarre metadati andando a identificare alcune sezioni specifiche da cui trarre informazioni sui documenti come autore, data di creazione, licenze e altro.

   - Immagina di voler strutturare un file di metadati YAML organizzato in tre categorie:  (i) gestione documentale, (ii) archiviazione, (iii) distribuzione.

     ```yaml
     # Metadati YAML per documenti
     gestione_documentale:
       title: "Guida Completa alla Gestione Documentale"
       author: 
         - "Paolo Ceravolo"
         - "Collaboratore A"
       date: "2024-11-17"
       abstract: "Un documento che esplora le migliori pratiche per la gestione documentale."
       keywords:
         - "Gestione documentale"
         - "Archiviazione"
         - "Distribuzione"
       lang: "it"
       bibliography: "references.bib"
       csl: "apa.csl"
       document_class: "report"
       output_formats:
         - pdf
         - html
         - docx
     
     archiviazione:
       dublin_core:
         title: "Guida Completa alla Gestione Documentale"
         creator: 
           - "Paolo Ceravolo"
           - "Collaboratore A"
         subject: 
           - "Gestione documentale"
           - "Archivistica"
         description: "Questo documento tratta delle migliori pratiche e tecniche per gestire e archiviare i documenti."
         publisher: "Università degli Studi di Milano"
         contributor: 
           - "Editor 1"
           - "Editor 2"
         date: "2024-11-17"
         type: "Manuale"
         format: "application/pdf"
         identifier: "ISBN-978-88-555-1234-5"
         language: "it"
         coverage: "Italia"
         rights: "Creative Commons Attribution 4.0 International License"
     
     distribuzione:
       onix:
         title: "Guida Completa alla Gestione Documentale"
         contributor:
           primary_author: "Paolo Ceravolo"
           other_authors:
             - "Collaboratore A"
         publisher: "Università degli Studi di Milano"
         publication_date: "2024-11-17"
         isbn: "978-88-555-1234-5"
         audience: "Professionisti, Accademici"
         format: 
           type: "Digital"
           file_format: "PDF"
         price:
           amount: "19.99"
           currency: "EUR"
       schema_org:
         "@context": "https://schema.org"
         "@type": "Book"
         name: "Guida Completa alla Gestione Documentale"
         author: 
           - "@type": "Person"
             name: "Paolo Ceravolo"
           - "@type": "Person"
             name: "Collaboratore A"
         datePublished: "2024-11-17"
         publisher: 
           "@type": "Organization"
           name: "Università degli Studi di Milano"
         isbn: "978-88-555-1234-5"
         genre: 
           - "Gestione documentale"
           - "Archivistica"
         language: "it"
         inLanguage: "Italian"
         format: "PDF"
     ```

4. **Trasformazione del formato dei metadati**

   - Scrivi uno script per trasformare i metadati YAML in diversi formati di destinazione, ad esempio ONIX e Schema.org 

5. **Unisci molteplici file Markdown in un unico documento** 

   - Utilizza le diverse sorgenti raccolte per generare il tuo documento finale

6. **Conversione del documento Markdown**

   - Sfrutta il file di metadati nelle conversioni Pandoc:

     ```bash
     pandoc documento.md --metadata-file=metadati.yaml --output=output.pdf --pdf-engine=xelatex
     ```

---
