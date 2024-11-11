# Esercizio: Creazione di un eBook per la distribuzione digitale

**Obiettivo:** Utilizzare Pandoc per trasformare un documento sorgente in formato HTML, arricchirlo con metadati e convertirlo in un eBook (in formato ePub) pronto per la distribuzione su piattaforme digitali.

## Istruzioni:

1. **Reperimento del Documento Sorgente**
   - Scarica un documento disponibile in formato aperto (ad esempio, da Project Gutenberg) in formato HTML o, se disponibile, in Markdown.
   - Esempio: *Al polo australe in velocipede* di Emilio Salgari da Project Gutenberg.

2. **Prova di trasformazione**
   
   - Se il documento è in HTML, usa Pandoc per convertirlo in EPUB:
     ```bash
     pandoc source.html -f html -t epub -o prova.epub
     ```
   
3. **Verifica la struttura del file HTML**

   - Se necessario, organizza i capitoli e i paragrafi, ad esempio introducendo un'interruzione di pagina prima di ogni capitolo 
   ```html
   <div style="page-break-before:always;"></div>
   ```
   - Eliminando i numeri di pagina che risulteranno diversi nel formato di destinazione 
   ```html
	<p>
	<span class="pagenum" id="Page_12">[12]</span>
	</p>
   ```

4. **Aggiunta dei metadati**

   - Crea un file YAML per i metadati, specificando informazioni come titolo, autore, data di pubblicazione, e lingua. 
   - Oltre a un formato è utile definire anche un vocabolario di riferimento, ad esempio Dublin Core 
   - Esempio di file `metadata.yaml`:
     ```yaml
     dc:contributor: ': Barbara Magni and the Online Distributed Proofreading Team at http://www.pgdp.net
       (This file was produced from images made available by The Internet Archive)'
     dc:creator: ': G. G. Bruno'
     dc:date: ': August 31, 2024 [eBook #74341]'
     dc:language: ': Italian'
     dc:publisher: ': Torino: Paravia'
     dc:title: ': Al polo australe in velocipede'
4. **Estrazione automatica dei metadati**
   - Per migliorare l'automazione del processo è possibile progettare uno script che estrae automaticamente i metadati dal file sorgente.

```python
#!/usr/bin/env python3

from bs4 import BeautifulSoup
import yaml

# Leggere il contenuto HTML da un file
with open("meta.html", "r", encoding="utf-8") as file:
    html_content = file.read()

# Creare un oggetto BeautifulSoup
soup = BeautifulSoup(html_content, 'html.parser')

# Estrarre i dati dai tag HTML
metadata = {
    "dc:title": soup.find("strong", string="Title").find_next_sibling(string=True).strip(),
    "dc:creator": soup.find("strong", string="Author").find_next_sibling(string=True).strip(),
    "dc:creator": soup.find("strong", string="Illustrator").find_next_sibling(string=True).strip(),  # Illustrator come creator se preferisci
    "dc:date": soup.find("strong", string="Release date").find_next_sibling(string=True).strip(),
    "dc:language": soup.find("strong", string="Language").find_next_sibling(string=True).strip(),
    "dc:publisher": soup.find("strong", string="Original publication").find_next_sibling(string=True).strip(),
    "dc:contributor": soup.find("strong", string="Credits").find_next_sibling(string=True).strip(),
}

# Convertire i dati in YAML
yaml_output = yaml.dump(metadata, allow_unicode=True)
print(yaml_output)
```

5. **Conversione in ePub**
   - Utilizza Pandoc per creare un eBook in formato ePub, incorporando i metadati e il contenuto del documento.
   - Esegui il comando:
     ```bash
     pandoc document.html --metadata-file=metadata.yaml -o ebook.epub
     ```
     
     Sì, quando utilizzi **Pandoc** per convertire un file HTML in **EPUB**, puoi arricchire il file di destinazione con metadati **YAML**. Pandoc ti permette di includere un blocco di metadati all'inizio del documento HTML che verrà poi trasmesso al file EPUB generato. I metadati YAML sono particolarmente utili per definire informazioni come titolo, autore, lingua, e altre proprietà del libro, che possono essere utilizzate nei lettori di ebook e nei motori di ricerca dei contenuti.
     
     Pandoc prenderà automaticamente il blocco di metadati YAML e lo includerà nel file EPUB generato. I metadati YAML verranno tradotti nelle informazioni del file EPUB, come il titolo, l'autore, la lingua, la data di pubblicazione, e altri attributi.
     
     Alcuni dei **metadati** comuni per **EPUB** che puoi includere nel blocco YAML sono:
     
     - `title`: Il titolo del libro.
     - `author`: L'autore del libro.
     - `language`: La lingua del libro.
     - `date`: La data di pubblicazione.
     - `publisher`: L'editore del libro.
     - `identifier`: L'ID univoco (ad esempio, un codice ISBN o un identificatore URN).
     - `rights`: I diritti d'autore (es. "Public domain", "Copyright").
     - `description`: Una breve descrizione del contenuto del libro.
     - `cover-image`: L'immagine di copertura (specifica il percorso dell'immagine da usare come copertura del libro).
     - `subjects`: Le categorie del libro (come parole chiave).
     - `creator`: Creatore o autore, spesso utilizzato in alternativa a `author`.
     
     Ecco un esempio di blocco YAML con più metadati:
     
     ```yaml
     ---
     title: "Al Polo Australe in Velocipede"
     author: "Emilio Salgari"
     language: "it"
     date: "2024-08-31"
     publisher: "G. B. Paravia"
     rights: "Public domain"
     identifier: "urn:isbn:1234567890"
     description: "Una descrizione del libro, un'avventura nelle terre antartiche."
     cover-image: "images/cover.jpg"
     subjects: ["adventure", "history", "travel"]
     ---
     ```
     
   
6. **Verifica del Risultato**

   - Apri il file `ebook.epub` con un lettore eBook (ad esempio, Calibre) e controlla:
     - La correttezza dei metadati visualizzati.
     - La struttura del documento, inclusi capitoli e intestazioni.
     - La formattazione del testo.

7. **Distribuzione (Facoltativa)**
   - Per approfondire, discuti come il file ePub potrebbe essere distribuito su piattaforme come Google Books, Amazon Kindle, o altre librerie digitali, soffermandosi sui requisiti di ciascuna piattaforma per i metadati e il formato.
