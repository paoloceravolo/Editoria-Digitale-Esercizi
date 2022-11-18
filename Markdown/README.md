# Esercizi con Pandoc


Frammento HTML:

``
pandoc MANUAL.txt -o example1.html
``

File standalone HTML:

``
pandoc -s MANUAL.txt -o example2.html
``

HTML con indice, CSS, e footer:

``
pandoc -s --toc -c es.css -A footer.html MANUAL.txt -o example3.html
``

LaTeX:

``
pandoc -s MANUAL.txt -o example4.tex
``

Generiamo un AST partendo da un documento Markdown

``
pandoc simple.md -w JSON -o ast.json
``

O anche come segue, visto che l'estesione del file suggerisce il formato del writer  

``
pandoc simple.md -o ast.json
``

ODT (OpenDocument Text, readable by OpenOffice):

``
pandoc MANUAL.txt -o example21.odt
``

Docx utilizzando un template docx:

``
pandoc --reference-doc twocolumns.docx -o UsersGuide.docx MANUAL.txt
``

Proviamo ad aggiungere dei metadati al documento simple.md:

```
---  
title: Plain Text Workflow  
author: ED class 
date: 20 novembre 2022  
---  

```

``
pandoc --reference-doc twocolumns.docx -o test.docx simple.md
``

Proviamo ad aggiungere la bibliografia:

```
---  
title: Plain Text Workflow  
author: ED class 
date: 20 novembre 2022  
bibliography: ref.bib
---  

```

All'interno del testo possiamo citare i riferimenti con:


``
Some sentence that needs citation [@barbon2020evaluating argues that too].
``

Possiamo poi inserire una sesione `## Bibliography` alla fine del documento.


Eseguiamo la trasformazione: 

``
pandoc -s -o test.docx --citeproc simple.md
``

Possiamo indicare lo stile della bibliografia da utilizzare: 



```
---  
title: Plain Text Workflow  
author: ED class 
date: 20 novembre 2022  
bibliography: ref.bib
csl: ieeetr.bst
---  

```

``
pandoc -s -o test.docx --citeproc simple.md
``