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
        quotes and citations.</xd:p>
    </xd:desc>
  </xd:doc>  
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>my:lang</xd:p>
      <xd:p>Template and function to convert ISO language
        codes into LaTeX Babel's codes</xd:p>
    </xd:desc>
    <xd:param name="lname"/>
  </xd:doc>
  <xsl:template name="my:lang">
    <xsl:param name="lname"/>
    <xsl:choose>
      <xsl:when test="$lname='ang'">english</xsl:when>
      <xsl:when test="$lname='enm'">english</xsl:when>
      <xsl:when test="$lname='eng'">english</xsl:when>
      <xsl:when test="$lname='lat'">latin</xsl:when>
      <xsl:when test="$lname='es'">spanish</xsl:when>
      <xsl:when test="$lname='fro'">french</xsl:when>
      <xsl:when test="$lname='frm'">french</xsl:when>
      <xsl:when test="$lname='fra'">french</xsl:when>
      <xsl:when test="$lname='grc'">greek</xsl:when>
      <xsl:when test="$lname='cym'">welsh</xsl:when>
      <xsl:when test="$lname='deu'">german</xsl:when>
      <xsl:otherwise>english</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xd:doc>
    <xd:desc>my:lang function</xd:desc>
    <xd:param name="lname"/>
  </xd:doc>
  <xsl:function name="my:lang" as="xs:string">
    <xsl:param name="lname"/>
    <xsl:call-template name="my:lang">
      <xsl:with-param name="lname" select="$lname"/>
    </xsl:call-template>
  </xsl:function>
  
  
  <!--=============================================-->
  <!--                     <foreign>               -->
  <!--                     <mentioned>             -->
  <!--                     <gloss>                 -->
  <!--                     <q[not(parent::cit)]>   -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>
      <xd:p>template to deal with standalone quotes</xd:p>
      <xd:ul>
        <xd:li>#1: lang</xd:li>
        <xd:li>#2: label</xd:li>
        <xd:li>#3: text</xd:li> 
      </xd:ul>
    </xd:desc>
  </xd:doc>
  <xsl:template match="foreign | mentioned | gloss | q[not(parent::cit)]">
    <xsl:text>\MyQ</xsl:text>
    <!--insert lang-->
    <xsl:text>{</xsl:text>
    <xsl:choose>
      <xsl:when test="@xml:lang or name(.)='foreign'">
        <xsl:sequence select="my:lang(@xml:lang)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>spanish</xsl:text> 
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}</xsl:text>
    <!--insert label-->
    <xsl:text>{</xsl:text>
    <xsl:if test="@xml:id">
      <xsl:value-of select="@xml:id"/>
    </xsl:if>
    <xsl:text>}</xsl:text>
    <!--insert text-->
    <xsl:text>{</xsl:text>
    <xsl:if test="@ana='lexeme'">
      <xsl:text>\lexquote{</xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:if test="@ana='lexeme'">
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>}</xsl:text>
  </xsl:template>
  
  
  
  <!--=============================================-->
  <!--                    <cit>                    -->
  <!--=============================================-->
  <!--cit / quote / q / ref-->
  <xd:doc>
    <xd:desc>
      <xd:p>citations</xd:p>
      <xd:p>cit[child::quote]</xd:p>
      <xd:ul>
        <xd:li>#1: language</xd:li>
        <xd:li>#2: label</xd:li>
        <xd:li>#3: original language text</xd:li>
        <xd:li>#4: translation text</xd:li>
        <xd:li>#5: reference</xd:li>
      </xd:ul>
    </xd:desc>
  </xd:doc>
  <xsl:template match="cit[child::quote]">
    <xsl:text>\MyC</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:sequence select="my:lang(quote/@xml:lang)"/>
    <xsl:text>}</xsl:text>
    <!--insert label-->
    <xsl:text>{</xsl:text>
    <xsl:if test="quote[@xml:id]">
      <xsl:value-of select="quote/@xml:id"/>
    </xsl:if>
    <xsl:text>}</xsl:text>
    <!--insert original quote-->
    <xsl:text>{</xsl:text>
    <xsl:apply-templates select="quote"/>
    <xsl:choose>
      <xsl:when test="q">
        <!--insert comma-->
        <xsl:text>,</xsl:text>
        <xsl:text>}</xsl:text>
        <!--insert q trans.-->
        <xsl:text>{</xsl:text>
        <xsl:apply-templates select="q"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <!--simply close group 
          and create an empy one -->
        <xsl:text>}</xsl:text>
        <xsl:text>{}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!--insert ref-->
    <xsl:text>{</xsl:text>
    <xsl:if test="ref">
      <xsl:text>(</xsl:text>
      <xsl:apply-templates select="ref"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:text>}</xsl:text>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>citations</xd:p>
      <xd:p>cit[not(child::quote)]</xd:p>
      <xd:p>citation without quote</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="cit[not(child::quote)]">
    <xsl:apply-templates/>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>quote</xd:desc>
  </xd:doc>
  <xsl:template match="quote">
    <xsl:choose>
      <xsl:when test="@ana='verse'">
        <xsl:text>\indentedpar{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  
  
  
  <xd:doc>
    <xd:desc>q</xd:desc>
  </xd:doc>
  <xsl:template match="q">
    <xsl:choose>
      <xsl:when test="@rend='indented'">
        <xsl:text>\indentedpar{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>  
  
  
  
</xsl:stylesheet>