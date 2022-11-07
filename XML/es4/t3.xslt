<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
	<html> <body>
		<h2>La mia collezione di CD</h2>
		<table border="1">
		<tr bgcolor="#9acd32">
			<th align="left">Titolo</th>
			<th align="left">Autore</th>
		</tr>
		<xsl:for-each select="elenco/cd">
			<tr>
				<td><xsl:value-of select="titolo"/></td>
				<td><xsl:value-of select="autore"/></td>
			</tr>
		</xsl:for-each>
		</table>
	</body></html>
</xsl:template>

<xsl:output method="xml" encoding="utf-8" indent="yes"/>
 
</xsl:stylesheet>