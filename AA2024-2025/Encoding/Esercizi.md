### Esercizio 1: Rappresentazione di un Testo in ASCII
**Descrizione**: Scrivi un programma che converta una stringa di testo fornita dall'utente nella sua rappresentazione in ASCII.

**Esempio**:  
Input: `"Hello"`  
Output: `[72, 101, 108, 108, 111]`

### Esercizio 2: Decodifica di un Testo in UTF-8
**Descrizione**: Fornisci agli studenti una serie di codici UTF-8 e chiedi loro di scrivere un programma per decodificare questi codici in testo leggibile.

**Esempio**:  
Input: `[0xE2, 0x82, 0xAC]` (che rappresenta il simbolo dell'euro €)  
Output: `"€"`

### Esercizio 3: Codifica Base64
**Descrizione**: Scrivi un programma che converta una stringa di testo in una rappresentazione Base64. Gli studenti dovranno anche implementare la funzione inversa per decodificare il testo.

**Esempio**:  
Input: `"Si stà come sugli alberi le foglie"`  
Output: `"U2kgc3TDoCBjb21lIHN1Z2xpIGFsYmVyaSBsZSBmb2dsaWU="`

### Esercizio 4: Analisi della Frequenza dei Caratteri
**Descrizione**: Scrivi un programma che analizzi la frequenza dei caratteri in un testo fornito dall'utente e mostri i risultati in ordine decrescente di frequenza.

**Esempio**:    
Input: `"Trentatrè trentini entrarono in Trento"`  
Output: [('n', 7), ('r', 6), ('t', 6), ('e', 4), (' ', 4), ('i', 3), ('o', 3), ('T', 2), ('a', 2), ('è', 1)]

### Esercizio 5: Rimozione del BOM da un File UTF-8

**Descrizione**: Dato un file di testo codificato in UTF-8 con BOM (Byte Order Mark), scrivere un programma che legga il contenuto del file e lo salvi nuovamente in un nuovo file senza il BOM.

### Esercizio 6: Identificazione del codifica di un file

**Descrizione**: Dato un file scrivere un programma che legga il contenuto del file e indichi quale codifica è stata utilizzata per crearlo.

**Suggerimento**: Una libreria Python adatta a questo è `chardet` 
