<!DOCTYPE stylesheet [
<!ENTITY blank  " - " ><!-- blank space -->
]>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="div"> 
	<html> 
		<h1><xsl:value-of select="@n"/>: <xsl:value-of select="head"/></h1>
		<p>Ingredients:<xsl:apply-templates select="list/item"/></p>
		<p><xsl:value-of select="p"/></p> 
	</html> 
</xsl:template>

<xsl:template match="list/item">
	<!--<xsl:text> </xsl:text>-->
    <xsl:value-of select="normalize-space()"/>
    <xsl:text>&blank;</xsl:text>
</xsl:template>

<xsl:template match="text()">
    <xsl:value-of select="normalize-space()"/>
</xsl:template>

</xsl:stylesheet>  