### Esercizio 1: Rappresentazione di un Testo in ASCII
**Descrizione**: Scrivi un programma che converta una stringa di testo fornita dall'utente nella sua rappresentazione in ASCII.

**Esempio**:  
Input: `"Hello"`  
Output: `[72, 101, 108, 108, 111]`

```python
def text_to_ascii(text):
    return [ord(char) for char in text]

# Test
text = "Hello"
ascii_codes = text_to_ascii(text)
print(f"ASCII Codes: {ascii_codes}")

```

### Esercizio 2: Decodifica di un Testo in UTF-8
**Descrizione**: Fornisci agli studenti una serie di codici UTF-8 e chiedi loro di scrivere un programma per decodificare questi codici in testo leggibile.

**Esempio**:  
Input: `[0xE2, 0x82, 0xAC]` (che rappresenta il simbolo dell'euro €)  
Output: `"€"`

```python
def utf8_to_text(utf8_codes):
    return bytes(utf8_codes).decode('utf-8')

# Test
utf8_codes = [0xE2, 0x82, 0xAC]  # Rappresenta il simbolo dell'euro (€)
text = utf8_to_text(utf8_codes)
print(f"Decoded Text: {text}")
```

### Esercizio 3: Codifica Base64
**Descrizione**: Scrivi un programma che converta una stringa di testo in una rappresentazione Base64. Gli studenti dovranno anche implementare la funzione inversa per decodificare il testo.

**Esempio**:  
Input: `"Si stà come sugli alberi le foglie"`  
Output: `"U2kgc3TDoCBjb21lIHN1Z2xpIGFsYmVyaSBsZSBmb2dsaWU="`

```python
import base64

def text_to_base64(text):
    text_bytes = text.encode('utf-8')
    base64_bytes = base64.b64encode(text_bytes)
    return base64_bytes.decode('utf-8')

def base64_to_text(base64_string):
    base64_bytes = base64_string.encode('utf-8')
    text_bytes = base64.b64decode(base64_bytes)
    return text_bytes.decode('utf-8')

# Test
text = "Si stà come sugli alberi le foglie"
encoded_text = text_to_base64(text)
decoded_text = base64_to_text(encoded_text)
print(f"Encoded Text (Base64): {encoded_text}")
print(f"Decoded Text: {decoded_text}")
```

### Esercizio 4: Analisi della Frequenza dei Caratteri
**Descrizione**: Scrivi un programma che analizzi la frequenza dei caratteri in un testo fornito dall'utente e mostri i risultati in ordine decrescente di frequenza.

**Esempio**:  
Input: `"Trentatrè trentini entrarono in Trento"`  
Output: [('n', 7), ('r', 6), ('t', 6), ('e', 4), (' ', 4), ('i', 3), ('o', 3), ('T', 2), ('a', 2), ('è', 1)]

```python
from collections import Counter

def char_frequency(text):
    frequency = Counter(text)
    return sorted(frequency.items(), key=lambda x: x[1], reverse=True)

# Test
text = "Trentatrè trentini entrarono in Trento"
frequency = char_frequency(text)
print(f"Character Frequency: {frequency}")
```

### Esercizio 5: Rimozione del BOM da un File UTF-8

**Descrizione**: Dato un file di testo codificato in UTF-8 con BOM (Byte Order Mark), scrivere un programma che legga il contenuto del file e lo salvi nuovamente in un nuovo file senza il BOM.

```python
def remove_bom(input_file, output_file):
    # Leggi il contenuto del file
    with open(input_file, 'rb') as file:
        content = file.read()

    # Controlla se il file inizia con il BOM UTF-8 (0xEF, 0xBB, 0xBF)
    BOM = b'\xef\xbb\xbf'
    if content.startswith(BOM):
        print("BOM trovato e rimosso.")
        content = content[len(BOM):]
    else:
        print("Nessun BOM trovato.")

    # Salva il contenuto senza BOM in un nuovo file
    with open(output_file, 'wb') as file:
        file.write(content)

# Test
input_file = 'test_with_bom.txt'  # File di input con BOM
output_file = 'test_without_bom.txt'  # File di output senza BOM
remove_bom(input_file, output_file)
print(f"Il file è stato salvato senza BOM come '{output_file}'")

```

### Esercizio 6: Identificazione del codifica di un file

**Descrizione**: Dato un file scrivere un programma che legga il contenuto del file e indichi quale codifica è stata utilizzata per crearlo.

**Suggerimento**: Una libreria Python adatta a questo è `chardet` 

```python
import chardet

def detect_file_encoding(file_path):
    with open(file_path, 'rb') as file:
        raw_data = file.read()  # Legge il file come dati binari
        result = chardet.detect(raw_data)  # Rileva la codifica
        encoding = result['encoding']
        confidence = result['confidence']
    
    return encoding, confidence

# Esempio di utilizzo
file_path = 'tuo_file.txt'  # Sostituisci con il percorso del tuo file
encoding, confidence = detect_file_encoding(file_path)
print(f"Codifica rilevata: {encoding} (confidenza: {confidence * 100:.2f}%)")
```

