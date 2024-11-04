<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/catalog">
        <db:book xmlns:db="http://docbook.org/ns/docbook">
            <db:title>Catalog of Books</db:title>
            <xsl:apply-templates select="book"/>
        </db:book>
    </xsl:template>

    <xsl:template match="book">
        <db:chapter>
            <db:title>Books</db:title>
            <db:bookinfo>
                <db:title>
                    <xsl:value-of select="title"/>
                </db:title>
                <db:author>
                    <db:personname>
                        <db:firstname>
                            <xsl:value-of select="substring-before(author, ',')"/>
                        </db:firstname>
                        <db:surname>
                            <xsl:value-of select="substring-after(author, ', ')"/>
                        </db:surname>
                    </db:personname>
                </db:author>
                <db:genre>
                    <xsl:value-of select="genre"/>
                </db:genre>
                <db:price>
                    <xsl:value-of select="price"/>
                </db:price>
                <db:pubdate>
                    <xsl:value-of select="publish_date"/>
                </db:pubdate>
                <db:description>
                    <xsl:value-of select="description"/>
                </db:description>
            </db:bookinfo>
        </db:chapter>
    </xsl:template>
</xsl:stylesheet>
