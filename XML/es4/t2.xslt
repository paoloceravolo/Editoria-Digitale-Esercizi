<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
	<html> <body>
		<h2>La mia collezione di CD</h2>
		<table border="1">
		<tr bgcolor="#9acd32">
			<th align="left">Titolo</th>
			<th align="left">Autore</th>
		</tr>
		<tr>
			<td><xsl:value-of select="elenco/cd/titolo"/></td>
			<td><xsl:value-of select="elenco/cd/autore"/></td>
		</tr>
		</table>
	</body></html>
</xsl:template>
</xsl:stylesheet>