## Esercizio: Creazione di un documento LaTeX con metadati e riferimenti bibliografici

**Obiettivo**: Utilizzando **Pandoc**, creeremo un documento in formato **LaTeX** a partire da un file sorgente in Markdown. Durante la trasformazione, verrà utilizzato un file di metadati che include:  
1. Informazioni per la **gestione documentale**.  
2. Metadati per l'**archiviazione**.  
3. Metadati per la **distribuzione** del documento.  
Inoltre, integreremo un file di bibliografia per inserire i riferimenti nel documento LaTeX.

1. **File sorgente Markdown**: `documento.md`  
   Preparate un breve testo in Markdown (per esempio, un riassunto di un articolo scientifico). Utilizza almeno un riferimento bibliografico e una formula matematica.  È possibile accedere ad un esempio dal progetto di [Jupyter-book](https://github.com/jupyter-book/jupyter-book/blob/main/docs/content/math.md). Un esempio molto semplice è riportato di seguito.

   ```markdown
   # Applicazione delle Reti Neurali alla Previsione Temporale
   
   Le reti neurali ricorrenti (RNN) sono state ampiamente utilizzate per affrontare problemi di previsione temporale, grazie alla loro capacità di modellare dipendenze a lungo termine nei dati sequenziali. Tuttavia, la loro efficacia è limitata da problemi come il vanishing gradient. Per superare tali difficoltà, sono stati introdotti modelli avanzati come le reti LSTM (Long Short-Term Memory) e GRU (Gated Recurrent Unit), che regolano dinamicamente il flusso delle informazioni attraverso meccanismi di gating.
   
   Un modello LSTM segue il principio di aggiornamento descritto dalla seguente equazione:
   
   $$
   h_t = o_t \odot \tanh(c_t), \quad c_t = f_t \odot c_{t-1} + i_t \odot \tilde{c}_t
   $$
   
   dove \( h_t \) rappresenta lo stato nascosto, \( c_t \) lo stato della cella, e \( i_t, f_t, o_t \) sono i gate di input, forget e output, rispettivamente.
   
   ## Risultati e Conclusioni
   
   Uno studio recente di Yang et al. [@yang2019traffic] ha mostrato che l'utilizzo di un'architettura LSTM in combinazione con feature engineering specifiche può migliorare significativamente la precisione della previsione di serie temporali rispetto ai metodi tradizionali basati su ARIMA o SARIMA.
   
   ```

2. **File di metadati YAML**: `metadati.yaml`  
   Crea un file di metadati che includa tre sezioni:  
   - **Gestione documentale** (es., titolo, autore, versione).  
   - **Archiviazione** (es., identificatore unico, data di ultima modifica).  
   - **Distribuzione** (es., licenza, formato preferito per la distribuzione).  

   ```yaml
   gestione_documentale:
     title: "Applicazione delle Reti Neurali alla Previsione Temporale"
     author: 
       - "Paolo Ceravolo"
       - "Collaboratore A"
     date: "2024-11-24"
     abstract: "Le reti neurali ricorrenti (RNN) sono state ampiamente utilizzate per affrontare problemi di previsione temporale."
     lang: "it"
     bibliography: "references.bib"
     csl: "apa.csl"
     document_class: "article"
     output_formats:
       - pdf
       - html
       - epub
   
   archiviazione:
     dublin_core:
       title: "Applicazione delle Reti Neurali alla Previsione Temporale"
       creator: 
         - "Paolo Ceravolo"
         - "Collaboratore A"
       subject: 
         - "Reti Neurali"
         - "Analisi Temporali"
       description: "Le reti neurali ricorrenti (RNN) sono state ampiamente utilizzate per affrontare problemi di previsione temporale.."
       publisher: "Università degli Studi di Milano"
       contributor: 
         - "Editor 1"
         - "Editor 2"
       date: "2024-11-24"
       type: "Article"
       format: "application/pdf"
       identifier: "DOI:10.1234/ia2024"
       language: "it"
       coverage: "Italia"
       rights: "CC BY-NC 4.0"
   
   distribuzione:
     onix:
       title: "Applicazione delle Reti Neurali alla Previsione Temporale"
       contributor:
         primary_author: "Paolo Ceravolo"
         other_authors:
           - "Collaboratore A"
       publisher: "Università degli Studi di Milano"
       publication_date: "2024-11-24"
       audience: "Professionisti, Accademici"
       format: 
         type: "Digital"
         file_format: "PDF"
       price:
         amount: "0"
         currency: "EUR"
     schema_org:
       "@context": "https://schema.org"
       "@type": "Book"
       name: "Applicazione delle Reti Neurali alla Previsione Temporale"
       author: 
         - "@type": "Person"
           name: "Paolo Ceravolo"
         - "@type": "Person"
           name: "Collaboratore A"
       datePublished: "2024-11-24"
       publisher: 
         "@type": "Organization"
         name: "Università degli Studi di Milano"
       isbn: "978-88-555-1234-5"
       genre: 
          - "Reti Neurali"
         - "Analisi Temporali"
       language: "it"
       inLanguage: "Italian"
       format: "PDF"
   ```

3. **File bibliografico**: `bibliografia.bib`  
   Utilizza uno strumento come Zotero o Google Scholar per esportare un file `.bib`, o scrivilo manualmente seguendo il formato BibTeX.  

   ```bibtex
   @article{yang2019traffic,
     title={Traffic flow prediction using LSTM with feature enhancement},
     author={Yang, Bailin and Sun, Shulin and Li, Jianyuan and Lin, Xianxuan and Tian, Yan},
     journal={Neurocomputing},
     volume={332},
     pages={320--327},
     year={2019},
     publisher={Elsevier}
   }
   ```

4. **Comando Pandoc**  
   Esegui il comando seguente per generare il documento LaTeX utilizzando il file sorgente Markdown e i metadati YAML:  
   ```bash
   pandoc documento.md -o documento.tex --metadata-file=metadati.yaml --bibliography=bibliografia.bib --csl=apa.csl --citeproc
   
   ```

5. **Verifica il file generato**  
   Apri il file `documento.tex` per verificare:  
   - Il contenuto del documento.  
   - La corretta integrazione dei riferimenti bibliografici.  
   - L'inserimento dei metadati YAML come `\title{}`, `\author{}` ecc.

6. **Compilazione del documento LaTeX**  
   Compila il file `.tex` per ottenere il PDF finale. In generale è necessario avere installato un sistema di distribuzione LaTeX. È possibile utilizzare anche un servizio web come [Overleaft](https://www.overleaf.com/). Pe compilare si può usare una GUI oppure si può usare il comando:  

   ```bash
   pdflatex documento.tex
   ```

---

#### **Risultato atteso**
Il file PDF generato deve includere:  
- Un titolo, un autore e una data, derivati dai metadati YAML.  
- Almeno un riferimento bibliografico correttamente formattato.  
- Una struttura coerente con il contenuto del file Markdown originale.

---

### **Estensione dell'esercizio**
- Integra un **indice analitico** nel documento finale.  
- Usa un convertitore per creare una versione in ePub a partire dal file Markdown e YAML.
