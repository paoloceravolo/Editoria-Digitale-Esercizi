<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:strip-space elements="*" />
 <xsl:output method="text" indent="no" />
<xsl:template match="/">
 Menu:<xsl:value-of select="/Menu/Title"/>
 Icecreams: <xsl:apply-templates select="/Menu/Icecreams/Icecream"/>
 </xsl:template>
<xsl:template match="Icecream">
 — <xsl:value-of select="." />
 </xsl:template>
</xsl:stylesheet>