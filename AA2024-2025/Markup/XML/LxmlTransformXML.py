from lxml import etree

# Caricare il documento XML
xml_doc = etree.parse('libro.xml')

# Caricare il file XSLT
xslt_doc = etree.parse('trasformazioneLibroDocBook.xslt')

# Creare un oggetto XSLT
transform = etree.XSLT(xslt_doc)

# Eseguire la trasformazione
result = transform(xml_doc)

# Salvare il risultato in un file
with open('risultatoDB.xml', 'wb') as output_file:
    output_file.write(etree.tostring(result, pretty_print=True, xml_declaration=True, encoding='UTF-8'))

# Stampa il risultato
print(result)
