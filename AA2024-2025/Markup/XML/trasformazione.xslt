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
                <h1>Book Catalog</h1>
                <xsl:for-each select="catalog/book">
                    <h2><xsl:value-of select="title"/></h2>
                    <p>Author: <xsl:value-of select="author"/></p>
                    <p>Genre: <xsl:value-of select="genre"/></p>
                    <p>Price: $<xsl:value-of select="price"/></p>
                    <hr/>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>