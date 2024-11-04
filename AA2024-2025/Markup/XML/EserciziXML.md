# Parte 1: Trasformazione XML in HTML utilizzando Python

## Istruzioni

### 1. Documento XML

Utilizza il seguente file XML (`books.xml`):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<catalog>
    <book id="bk101">
        <author>Gambardella, Matthew</author>
        <title>XML Developer's Guide</title>
        <genre>Computer</genre>
        <price>44.95</price>
        <publish_date>2000-10-01</publish_date>
        <description>An in-depth look at creating applications with XML.</description>
    </book>
    <book id="bk102">
        <author>Ralls, Kim</author>
        <title>Midnight Rain</title>
        <genre>Fantasy</genre>
        <price>5.95</price>
        <publish_date>2000-12-16</publish_date>
        <description>A former architect battles corporate zombies, an evil sorceress, and her own childhood to become queen of the world.</description>
    </book>
</catalog>
```

### 2. File XSLT

Scrivi un file XSLT (`transform.xsl`) per trasformare l'XML in HTML. Il tuo XSLT deve:
- Visualizzare il titolo di ciascun libro come intestazione.
- Elencare l'autore, il genere e il prezzo sotto ciascun titolo.
- Stilizzare l'HTML utilizzando CSS di base incorporato nel file XSLT.

#### Soluzione

`transform.xsl`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <style>
                    body { font-family: Arial, sans-serif; }
                    h2 { color: blue; }
                </style>
            </head>
            <body>
                <h1>Catalogo Libri</h1>
                <xsl:for-each select="catalog/book">
                    <h2><xsl:value-of select="title"/></h2>
                    <p>Autore: <xsl:value-of select="author"/></p>
                    <p>Genere: <xsl:value-of select="genre"/></p>
                    <p>Prezzo: $<xsl:value-of select="price"/></p>
                    <hr/>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
```

### 3. Applicazione dell'XSLT

Applica l'XSLT al file XML utilizzando un processore XSLT (come uno strumento online o un software locale) per generare il file HTML.

---

# Parte 2: Trasformazione XML in JSON Utilizzando Python

## Istruzioni

### 1. Script Python

Utilizzando lo stesso file XML (`books.xml`), scrivi uno script Python per convertire i dati XML in formato JSON. Ogni libro deve essere rappresentato come un oggetto JSON all'interno di una lista.

### 2. Uscita JSON

L'output JSON dovrebbe apparire così:

```json
[
    {
        "id": "bk101",
        "author": "Gambardella, Matthew",
        "title": "XML Developer's Guide",
        "genre": "Computer",
        "price": 44.95,
        "publish_date": "2000-10-01",
        "description": "An in-depth look at creating applications with XML."
    },
    {
        "id": "bk102",
        "author": "Ralls, Kim",
        "title": "Midnight Rain",
        "genre": "Fantasy",
        "price": 5.95,
        "publish_date": "2000-12-16",
        "description": "A former architect battles corporate zombies, an evil sorceress, and her own childhood to become queen of the world."
    }
]
```

### 3. Soluzione

```python
import xml.etree.ElementTree as ET
import json

# Analizza il file XML
tree = ET.parse('books.xml')
root = tree.getroot()

# Converti i dati XML in una lista di dizionari
books = []
for book in root.findall('book'):
    book_data = {
        "id": book.get('id'),
        "author": book.find('author').text,
        "title": book.find('title').text,
        "genre": book.find('genre').text,
        "price": float(book.find('price').text),
        "publish_date": book.find('publish_date').text,
        "description": book.find('description').text,
    }
    books.append(book_data)

# Converti la lista di dizionari in JSON
books_json = json.dumps(books, indent=4)

# Stampa l'output JSON
print(books_json)

# Salva l'output JSON in un file
with open('books.json', 'w') as json_file:
    json_file.write(books_json)
```

---

# Esercizio di Trasformazione XML in DocBook

## Obiettivo

L'obiettivo di questo esercizio è trasformare un documento XML generico che descrive un libro in un formato DocBook utilizzando un foglio di stile XSLT. Includeremo metadati, un capitolo con un paragrafo e un'immagine.

## 1. Esempio di Documento XML

Di seguito è riportato un esempio di documento XML che descrive un libro, completo di metadati, un capitolo con un paragrafo e un'immagine:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<bookstore>
    <book>
        <title>The Great Gatsby</title>
        <author>F. Scott Fitzgerald</author>
        <genre>Fiction</genre>
        <price>10.99</price>
        <publish_date>1925-04-10</publish_date>
        <description>A story about the jazz age in the United States.</description>
        
        <chapter>
            <title>Capitolo 1</title>
            <paragraph>
                In my younger and more vulnerable years my father gave me some advice 
                that I’ve been turning over in my mind ever since.
            </paragraph>
            <image src="gatsby_cover.jpg" alt="Copertina di The Great Gatsby"/>
        </chapter>
    </book>
</bookstore>
```

## 2. Foglio di Stile XSLT

Il seguente foglio di stile XSLT trasforma il documento XML generico in formato DocBook:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/bookstore">
        <db:book xmlns:db="http://docbook.org/ns/docbook">
            <db:title>
                <xsl:value-of select="book/title"/>
            </db:title>
            <db:author>
                <db:personname>
                    <db:firstname>
                        <xsl:value-of select="substring-before(book/author, ' ')"/>
                    </db:firstname>
                    <db:surname>
                        <xsl:value-of select="substring-after(book/author, ' ')"/>
                    </db:surname>
                </db:personname>
            </db:author>
            <db:genre>
                <xsl:value-of select="book/genre"/>
            </db:genre>
            <db:price>
                <xsl:value-of select="book/price"/>
            </db:price>
            <db:pubdate>
                <xsl:value-of select="book/publish_date"/>
            </db:pubdate>
            <db:description>
                <xsl:value-of select="book/description"/>
            </db:description>

            <db:chapter>
                <db:title>
                    <xsl:value-of select="book/chapter/title"/>
                </db:title>
                <db:para>
                    <xsl:value-of select="book/chapter/paragraph"/>
                </db:para>
                <db:mediaobject>
                    <db:imageobject>
                        <db:imagedata>
                            <xsl:attribute name="fileref">
                                <xsl:value-of select="book/chapter/image/@src"/>
                            </xsl:attribute>
                        </db:imagedata>
                        <db:alt>
                            <xsl:value-of select="book/chapter/image/@alt"/>
                        </db:alt>
                    </db:imageobject>
                </db:mediaobject>
            </db:chapter>
        </db:book>
    </xsl:template>
</xsl:stylesheet>
```

## 3. Esecuzione della Trasformazione

Per applicare il foglio di stile XSLT al documento XML, puoi utilizzare un processore XSLT come `xsltproc`. Ecco un esempio di comando da eseguire nel terminale:

```bash
xsltproc transform.xsl books.xml > books.docbook
```

Questo comando genererà un file `books.docbook` contenente il libro in formato DocBook.
