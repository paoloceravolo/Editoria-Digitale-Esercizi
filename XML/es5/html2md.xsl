<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8" indent="yes"/>
<xsl:strip-space elements="pre"/>
	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>


	<xsl:template match="h1">
		<xsl:text># </xsl:text>
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="h2">
		<xsl:text>## </xsl:text>
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="h3">
		<xsl:text>## </xsl:text>
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="pre">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="blockquote">
		<xsl:text>> </xsl:text>
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="hr">
		<xsl:text>---&#10;</xsl:text>
	</xsl:template>

	<xsl:template match="br">
		<xsl:text>&#10;</xsl:text>
	</xsl:template>

	<xsl:template match="a">
		<xsl:text>[</xsl:text>
		<xsl:value-of select="." />
		<xsl:text>](</xsl:text>
		<xsl:value-of select="@href" />
		<xsl:text>)</xsl:text>
	</xsl:template>

</xsl:stylesheet>