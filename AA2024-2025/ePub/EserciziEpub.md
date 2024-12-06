### Esercizio 1: Creazione di un eBook semplice con Markdown

**Istruzioni**:

- Scrivi un breve documento in Markdown che contenga:

  - Un titolo.
  - Almeno due sezioni con sottotitoli.
  - Un link ipertestuale.
  - Un'immagine.

- Converti il file Markdown in EPUB utilizzando Pandoc

  ```bash
  pandoc -o mio_ebook.epub mio_file.md
  ```

- Visualizza il risultato con un lettore EPUB (es. Calibre o Okular).

---

### **Esercizio 2: Analizzare la struttura interna di un EPUB**

**Istruzioni**:

- Scarica un eBook in formato EPUB.
- Cambia l'estensione del file da `.epub` a `.zip` e decomprimi l'archivio.
- Esplora i file e rispondi alle seguenti domande:
  - Quali sono i file principali che trovi nella directory?
  - Quale file definisce la struttura del libro (indice e capitoli)?
  - Quali file contengono lo stile visivo del libro?

---

### **Esercizio 3: Esplorare la struttura di un EPUB**

**Istruzioni**

- Scegli un file EPUB esistente.
- Cambia l’estensione del file da `.epub` a `.zip`.
- Decomprimi l’archivio usando uno strumento come **7-Zip** o **WinRAR**.
- Identifica e analizza i seguenti file o cartelle:
  - `mimetype`: Verifica che il contenuto sia `application/epub+zip`.
  - `/META-INF/container.xml`: Comprendi il ruolo di questo file nella definizione della posizione del file principale (`.opf`).
  - `/OEBPS/content.opf`: Analizza la struttura di base (manifest, spine, metadati).
- Rispondi:
  - Qual è il ruolo del file `content.opf`?
  - Dove sono memorizzati i file HTML e CSS?

---

### **Esercizio 4: Modifica dei metadati nel file OPF**

**Istruzioni**

- Apri il file `content.opf` in un editor di testo (es. SublimeText, VS Code).

- Aggiungi o modifica i seguenti campi nei metadati:

  - Titolo (`<dc:title>`).
  - Autore (`<dc:creator>`).
  - Lingua (`<dc:language>`).

- Comprimi di nuovo i file nella struttura originale per creare un nuovo EPUB.

- Verifica le modifiche aprendo il file in un lettore EPUB (es. Calibre).

  ---

### **Esercizio 5: Personalizzare lo stile del testo**

**Istruzioni**

- Identifica il file CSS nella cartella `/OEBPS` (es. `styles.css`).

- Modifica lo stile del testo:

  - Cambia il font in `Georgia`.
  - Imposta l’interlinea a `1.5`.
  - Modifica il colore del testo dei titoli (`h1`, `h2`) in blu.

- Salva le modifiche e ricrea il file EPUB.

- Verifica il nuovo stile aprendo l’EPUB in un lettore.

  ---

**Esercizio 6: Modifica del contenuto HTML**

**Istruzioni**

- Apri uno dei file HTML nella cartella `/OEBPS`.

- Aggiungi:

  - Un nuovo paragrafo di testo.
  - Un’immagine (inserendo anche il file immagine nella cartella `/OEBPS/images` e aggiornando il riferimento).

- Aggiorna il file `content.opf` per includere l'immagine nel `manifest`.

- Comprimi i file e verifica che l’eBook sia aggiornato.

  ---

### **Esercizio 6: Creare un indice (TOC) personalizzato**

**Istruzioni**

- Apri il file `/OEBPS/toc.ncx`.

- Aggiungi un nuovo elemento

  ```
  <navPoint>
  ```

  con:

  - Il titolo del capitolo.
  - Il link al file HTML corrispondente.

- Aggiorna il file `content.opf` per includere il nuovo capitolo nella `spine`.

- Ricrea il file EPUB e verifica che il nuovo capitolo sia accessibile dall’indice del lettore.

  ---

### **Esercizio 7: Inserire contenuti multimediali**

**Istruzioni**

- Copia un file multimediale nella cartella `/OEBPS/media`.

- Modifica un file HTML per includere un tag `<audio>` o `<video>` che punti al file multimediale.

- Aggiorna il file `content.opf` per includere il file multimediale nel `manifest`.

- Comprimi i file e verifica che l’eBook funzioni su un lettore compatibile (es. Apple Books).

  ---

### **Esercizio 8: Riparare un EPUB corrotto**

**Istruzioni**

- Scarica un EPUB con errori intenzionali (fornito dall’insegnante).

- Usa strumenti come EPUBCheck per identificare i problemi:

  ```bash
  epubcheck mio_ebook.epub
  ```

- Correggi gli errori rilevati (es. riferimenti mancanti, errori nel file OPF).
