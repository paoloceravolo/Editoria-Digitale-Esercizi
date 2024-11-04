from lxml import etree

# Caricare il documento XML
xml_doc = etree.parse('documento.xml')

# Caricare il file XSLT
xslt_doc = etree.parse('trasformazione.xslt')

# Creare un oggetto XSLT
transform = etree.XSLT(xslt_doc)

# Eseguire la trasformazione
result = transform(xml_doc)

# Salvare il risultato in un file HTML
with open('risultato.html', 'wb') as output_file:
    # Specifica l'header HTML5 se necessario
    output_file.write(b'<!DOCTYPE html>\n')  # Aggiungi dichiarazione DOCTYPE
    output_file.write(etree.tostring(result, pretty_print=True, encoding='UTF-8'))

# Stampa il risultato
print(result)