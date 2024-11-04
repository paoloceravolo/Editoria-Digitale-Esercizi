<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/bookstore">
        <db:book xmlns:db="http://docbook.org/ns/docbook">
            <db:title>
                <xsl:value-of select="book/title"/>
            </db:title>
            <db:author>
                <db:personname>
                    <db:firstname>
                        <xsl:value-of select="substring-before(book/author, ' ')"/>
                    </db:firstname>
                    <db:surname>
                        <xsl:value-of select="substring-after(book/author, ' ')"/>
                    </db:surname>
                </db:personname>
            </db:author>
            <db:genre>
                <xsl:value-of select="book/genre"/>
            </db:genre>
            <db:price>
                <xsl:value-of select="book/price"/>
            </db:price>
            <db:pubdate>
                <xsl:value-of select="book/publish_date"/>
            </db:pubdate>
            <db:description>
                <xsl:value-of select="book/description"/>
            </db:description>

            <!-- Capitolo -->
            <db:chapter>
                <db:title>
                    <xsl:value-of select="book/chapter/title"/>
                </db:title>
                <db:para>
                    <xsl:value-of select="book/chapter/paragraph"/>
                </db:para>

                <!-- Immagine -->
                <db:mediaobject>
                    <db:imageobject>
                        <db:imagedata>
                            <xsl:attribute name="fileref">
                                <xsl:value-of select="book/chapter/image/@src"/>
                            </xsl:attribute>
                        </db:imagedata>
                        <db:alt>
                            <xsl:value-of select="book/chapter/image/@alt"/>
                        </db:alt>
                    </db:imageobject>
                </db:mediaobject>
            </db:chapter>
        </db:book>
    </xsl:template>
</xsl:stylesheet>