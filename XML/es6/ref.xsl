<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:tei="http://www.tei-c.org/ns/1.0"  
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:my="http://nicolasvaughan.org"
  exclude-result-prefixes="tei my xd xs"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="3.0">
  
  
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b>2020-06-01</xd:p>
      <xd:p><xd:b>Author:</xd:b>nivaca</xd:p>
      <xd:p>This file contains templates dealing with
        internal and external references.</xd:p>
    </xd:desc>
  </xd:doc>  
  
  
  
  <!--=============================================-->
  <!--             function my:cleanref            -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>function my:cleanref</xd:desc>
    <xd:desc>Changes '_' into '-' in xml:id, needed for LaTeX,
      and removes '#' chars.</xd:desc>
    <xd:param name="input"/>
  </xd:doc>
  <xsl:function name="my:cleanref" as="xs:string">
    <xsl:param name="input"/>
    <xsl:variable name="temp" select="replace($input, '_', '-')"/>
    <xsl:sequence select="replace($temp, '#', '')"/>
  </xsl:function>
  
  
  
  <!--=============================================-->
  <!--             function my:cleanurl            -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>function my:cleanurl</xd:desc>
    <xd:desc>Protects URLs for LaTeX:
      escapes # and % chars.</xd:desc>
    <xd:param name="input"/>
  </xd:doc>
  <xsl:function name="my:cleanurl" as="xs:string">
    <xsl:param name="input"/>
    <xsl:variable name="temp" select="replace($input, '#', '\\#')"/>
    <xsl:sequence select="replace($temp, '%', '\\%')"/>
  </xsl:function>
  
  
  <!--
    #####################
    ref @type
    #####################
  -->
  <xd:doc>
    <xd:desc>
      <xd:p>function my:processref</xd:p>
      <xd:p>helps process refs according to type</xd:p>
      <xd:ul>
        <li>a:        \citeauthor</li>
        <li>p:        \parencite</li>
        <li>t:        \citetitle</li>
        <li>y:        \citeyear</li>
        <li>py:       \citeyear in parenthesis</li>
        <li>abbr:     \citeabbr</li>
        <li>pabbr:    \citeabbr in parenthesis: (ZSM, 297)</li>
        <li>abbrpc:   \citeabbr (content)</li>
        <li>fulltext: use text/rend without calling LaTeX's cite</li>
        <li>nc:       \nocite</li>
        <li>pnc:      \nocite in parenthesis</li>
        <li>url:      \href</li>
        <li>note:     \ref</li>
      </xd:ul>
    </xd:desc>
    <xd:param name="type"/>
  </xd:doc>
  <xsl:function name="my:processref">
    <xsl:param name="type"/>
    <xsl:choose>
      <xsl:when test="$type='a'">
        <xsl:text>\citeauthor*</xsl:text>
      </xsl:when>
      <xsl:when test="$type='p'">
        <xsl:text>\parencite</xsl:text>
      </xsl:when>
      <xsl:when test="$type='t'">
        <xsl:text>\citetitle</xsl:text>
      </xsl:when>
      <xsl:when test="$type='y'">
        <xsl:text>\citeyear</xsl:text>
      </xsl:when>
      <xsl:when test="$type='py'">
        <xsl:text>\parencite*</xsl:text>
      </xsl:when>
      <xsl:when test="$type='abbr'">
        <xsl:text>\citeabbr</xsl:text>
      </xsl:when>
      <xsl:when test="$type='pabbr'">
        <xsl:text>\citeabbr*</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <!--debug!-->
        <xsl:text>\myerror{}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  
  
  <xd:doc>
    <xd:desc>ref[@type='note']</xd:desc>
  </xd:doc>
  <xsl:template match="ref[@type='note']" priority="2">
    <xsl:text>\smnoteanchor{</xsl:text>
    <xsl:value-of select="my:cleanref(@target)"/>
    <xsl:text>}</xsl:text>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>ref[@type='abbrpc']</xd:desc>
  </xd:doc>
  <xsl:template match="ref[@type='abbrpc']" priority="2">
    <xsl:text>\citeabbr{</xsl:text>
    <xsl:value-of select="my:cleanref(@target)"/>
    <xsl:text>}</xsl:text>
    <!--insert rend/text-->
    <xsl:text>\space(</xsl:text>
    <xsl:choose>
      <!--select @rend if present-->
      <xsl:when test="@rend">
        <xsl:value-of select="@rend"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>)</xsl:text>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>ref[@type='nc' or @type='pnc']</xd:p>
      <xd:p>nocite refs</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="ref[@type='nc' or @type='pnc']" priority="2">
    <xsl:text>\nocite{</xsl:text>
    <xsl:value-of select="my:cleanref(@target)"/>
    <xsl:text>}</xsl:text>
    <!--insert rend/text-->
    <xsl:if test="@type='pnc'">
      <xsl:text>(</xsl:text>
    </xsl:if>
    <xsl:choose>
      <!--select @rend if present-->
      <xsl:when test="@rend">
        <xsl:value-of select="@rend"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@type='pnc'">
      <xsl:text>)</xsl:text>
    </xsl:if>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>ref[@type='fulltext']</xd:p>
      <xd:p>simply insert ref contents</xd:p>
      <xd:p>no LaTeX cite</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="ref[@type='fulltext']" priority="2">
    <xsl:apply-templates/>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>ref[@type='url']</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="ref[@type='url']" priority="2">
    <xsl:text>\href</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:sequence select="my:cleanurl(@target)"/>
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>all standalone ref</xd:p>
      <xd:p>(only internal xrefs)</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="ref[@type='internal']" priority="2">
    <xsl:text>\hyperref[</xsl:text>
    <xsl:sequence select="my:cleanref(@target)"/>
    <xsl:text>]{</xsl:text>
    <xsl:choose>
      <!--select @rend if present-->
      <xsl:when test="@rend">
        <xsl:value-of select="@rend"/>
      </xsl:when>
      <xsl:otherwise>
        <!--only if ref has content-->
        <xsl:if test="./text()">
          <xsl:apply-templates/>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}</xsl:text>
  </xsl:template>
  
  
  
  
  <xd:doc>
    <xd:desc>ref[parent::cit]</xd:desc>
  </xd:doc>
  <xsl:template match="ref[parent::cit]">
    <!--Two possibilities:
      1. refers to EnM or Lat editions (incunabula)
      2. refers to a bibliographic entry-->
    <xsl:choose>
      <!--                                                        -->
      <!--                1. refers to incunabula                 -->
      <!--                                                        -->
      <xsl:when test="@target[starts-with(.,'salmarc')]">
        <xsl:text>\LinkSM{</xsl:text>
        <xsl:choose>
          <!--select @rend if present-->
          <xsl:when test="@rend">
            <xsl:text>{</xsl:text>
            <xsl:value-of select="@rend"/>
            <xsl:text>}</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>{</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>}</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <!--                                                        -->
      <!--       2. refers to a normal bibliographic entry        -->
      <!--                                                        -->
      <xsl:when test="@target[starts-with(.,'#')] 
        and not(starts-with(@corresp, 'vulgClem'))">
        <xsl:choose>
          <xsl:when test="@type">
            <xsl:sequence select="my:processref(@type)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>\cite</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <!-- -->
        <!--insert text/rend-->
        <xsl:choose>
          <!--select @rend if present-->
          <xsl:when test="@rend">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="@rend"/>
            <xsl:text>]</xsl:text>
          </xsl:when>
          <!--if there is any content, push it-->
          <xsl:when test="text()">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
        <!-- -->
        <!--insert key-->
        <xsl:text>{</xsl:text>
        <xsl:value-of select="my:cleanref(@target)"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <!--Vulgata-->
      <xsl:when test="starts-with(@corresp, 'vulgClem')">
        <xsl:text>\VulgCit</xsl:text>
        <xsl:text>{</xsl:text>
        <xsl:sequence select="my:cleanref(@target)"/>
        <xsl:text>}</xsl:text>
        <xsl:choose>
          <!--select @rend if present-->
          <xsl:when test="@rend">
            <xsl:text>{</xsl:text>
            <xsl:value-of select="@rend"/>
            <xsl:text>}</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>{</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>}</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!--debug!-->
        <xsl:text>\marginpar{\textcolor{red}{</xsl:text>
        <xsl:text>ERROR!</xsl:text>
        <xsl:text>}}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  
</xsl:stylesheet>