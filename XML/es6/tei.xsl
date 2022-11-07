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
      <xd:p>This file contains standard templates for generating
        TeX from TEI.</xd:p>
    </xd:desc>
  </xd:doc>  
  
  
  
  <!-- -  -  -  -  -  -  IMPORTS  -  -  -  -  -  - 
  
  <xd:doc>
    <xd:desc>
      <xd:p>contains x-ref related templates</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:import href="ref.xsl"/> 
  
  <xd:doc>
    <xd:desc>
      <xd:p>contains citation related templates</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:import href="quote.xsl"/>
  
   -  -  -  -  -  -  -  -  -  -  -  -  -  -  - -->
  
  
  <xd:doc>
    <xd:desc>Variables from XML teiHeader</xd:desc>
  </xd:doc>
  <xsl:variable name="title"><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/></xsl:variable>
  <xsl:variable name="author"><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/author"/></xsl:variable>
  <xsl:variable name="editor"><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/editor"/></xsl:variable>
  <xsl:param name="targetdirectory">null</xsl:param>
  
  
  
  <xd:doc>
    <xd:desc>get versioning numbers</xd:desc>
  </xd:doc>
  <xsl:param name="sourceversion"><xsl:value-of select="/TEI/teiHeader/fileDesc/editionStmt/edition/@n"/></xsl:param>
  <xsl:param name="sourcedate"><xsl:value-of select="/TEI/teiHeader/fileDesc/editionStmt/edition/date/@when"/></xsl:param>
  
  
  
  <xd:doc>
    <xd:desc>combined version number should have mirror syntax of an equation x+y source+conversion</xd:desc>
  </xd:doc>
  <xsl:variable name="combinedversionnumber">
    <xsl:value-of select="$sourceversion"/><xsl:text>, </xsl:text>
    <xsl:value-of select="$sourcedate"/>
  </xsl:variable>
  
  
  
  <xd:doc>
    <xd:desc>Processing variables</xd:desc>
  </xd:doc>
  <xsl:variable name="fs"><xsl:value-of select="/TEI/text/body/div/@xml:id"/></xsl:variable>
  <xsl:variable name="name-list-file">prosopography.xml</xsl:variable>
  <xsl:variable name="work-list-file">bibliography.xml</xsl:variable>
  
  
  
  <xd:doc>
    <xd:desc>Begin: document configuration</xd:desc>
  </xd:doc>
  
  <xsl:output method="text" encoding="UTF-8" indent="no"/>
  
  <xd:doc>
    <xd:desc>Swallow multiple whitespace characters.
    </xd:desc>
  </xd:doc>
  <xsl:template match="text()">
    <xsl:value-of select="replace(., '\s+', ' ')"/>
  </xsl:template>
  
  


  <!--=============================================-->
  <!--             function my:cleantext           -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>function my:cleantext</xd:desc>
    <xd:desc>Deals with multiple whitespace characters
      and normalizes them.</xd:desc>
    <xd:param name="input"/>
  </xd:doc>
  <xsl:function name="my:cleantext">
    <xsl:param name="input"/>
    <xsl:variable name="step1" select="replace($input, '\n+', ' ')"/>
    <xsl:variable name="step2" select="normalize-space($step1)"/>
    <xsl:sequence select="$step2"/>
  </xsl:function>
  
  
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
  <!--                main template                -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>Main template</xd:desc>
  </xd:doc>
  <xsl:template match="/">
\def\SMVersion{<xsl:value-of select="$combinedversionnumber"/>}
\input{smpreamble.tex}
% -----------------------------------------------
\begin{document}

\input{frontmatter.tex}
\mainmatter
\pagestyle{smtrad}
\chapterstyle{smtrad}

<xsl:apply-templates select="//body"/>

\input{backmatter.tex}
\end{document}
% ===============================================
  </xsl:template>
  
  
  
  <!--=============================================-->
  <!--                    <div>                    -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>
      <xd:p>div[child::head]</xd:p>
      <xd:p>level1 are part divisions</xd:p>
      <xd:p>level2 are chapter divisions</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="div[child::head]">
    <xsl:text>&#10;&#10;</xsl:text>
    <xsl:choose>
      <xsl:when test="head[@ana='level1']">
        <xsl:text>\part</xsl:text>
      </xsl:when>
      <xsl:when test="head[@ana='level2']">
        <xsl:text>\chapter</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>\section</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>{</xsl:text>
    <xsl:copy-of select="head"/>
    <xsl:text>}</xsl:text>
    <xsl:if test="@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="my:cleanref(@xml:id)"/>
      <!--<xsl:value-of select="@xml:id"/>-->
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>&#10;&#10;</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>
  
  
  
  <!--=============================================-->
  <!--                    <head>                    -->
  <!--=============================================-->
  
  <xd:doc>
    <xd:desc>
      <xd:p>head</xd:p>
      <xd:p>Ignore standalone head</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="head">
    <!--<xsl:apply-templates/>-->
  </xsl:template>
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>head[note]</xd:p>
      <xd:p>head containing notes</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="head[note]">
    <xsl:apply-templates/>
  </xsl:template>



  <!--=============================================-->
  <!--                    <p>                    -->
  <!--=============================================-->
  
  <xd:doc>
    <xd:desc>
      <xd:p>p</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="p">
    <xsl:if test="@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="my:cleanref(@xml:id)"/>
      <!--<xsl:value-of select="@xml:id"/>-->
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:choose>
      <!--special centered paragraph, quasi header-->
      <xsl:when test="@ana='h1' or @ana='h2'">
        <xsl:text>
          \begin{adjustwidth}{.2\textwidth}{.2\textwidth}
          \begin{center}</xsl:text>
        <xsl:if test="@ana='h1'">
          <xsl:text>\large{}</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:text>\end{center}
          \end{adjustwidth}
          
          \bigskip</xsl:text>
      </xsl:when>
      <!--indented paragraph-->
      <xsl:when test="@rend='indented'">
        <xsl:text>\begin{indentedpar}</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\end{indentedpar}</xsl:text>
      </xsl:when>
      <!-- -->
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>p[parent::note]</xd:p>
      <xd:p>paragraphs inside notes</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="p[parent::note]">
    <xsl:if test="@n >1 and not(@rend='nofirstlineindent')">
      <xsl:text>&#10;&#10;</xsl:text>
      <!--<xsl:text>\par\hspace*{14pt}</xsl:text>-->
      <xsl:text>\parindent14pt</xsl:text>
      <xsl:text>&#10;&#10;</xsl:text>
    </xsl:if>
    <xsl:choose>
      <!--indented paragraph-->
      <xsl:when test="@rend='indented'">
        <xsl:text>\begin{indentedpar}</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\end{indentedpar}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
        <!--only insert \par if next paragraph 
          doesn't include a quote-->
        <xsl:if test="not(following-sibling::p[descendant::quote])">
          <xsl:text>\par</xsl:text>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  
  <!-- - - - - - - - - - - - - - - - - - - - -->
  <!--                   <lb>                -->
  <!-- - - - - - - - - - - - - - - - - - - - -->
  
    <xd:doc>
    <xd:desc>
      <xd:p>lb[@type='nonumber']</xd:p>
      <xd:p>line break with no numbering</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="lb[@type='nonumber']" priority="2">
    <xsl:text>\label{</xsl:text>
    <xsl:value-of select="my:cleanref(@xml:id)"/>
    <!--<xsl:value-of select="@xml:id"/>-->
    <xsl:text>}</xsl:text>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>lb[@n='1']</xd:p>
      <xd:p>the first line break in a paragraph</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="lb[@n='1']">
    <xsl:text>&#10;&#10;{\tiny\sidepar{\small¶</xsl:text>
    <xsl:value-of select="../@n"/>
    <xsl:text>}}</xsl:text>
    <xsl:text>\hspace*{14pt}</xsl:text>
    <xsl:text>\Linum{</xsl:text>
    <xsl:value-of select="@n"/>
    <xsl:text>}</xsl:text>
    <xsl:text>\label{</xsl:text>
    <xsl:value-of select="my:cleanref(@xml:id)"/>
    <!--<xsl:value-of select="@xml:id"/>-->
    <xsl:text>}~</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>lb</xd:p>
      <xd:p>normal line breaks</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="lb">
    <!--do not insert \n if its parent is a<q> -->
    <xsl:if test="not(parent::q)">
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:choose>
      <!--        only for Dialogue:      -->
      <xsl:when test="../@n='4'">
        <!--<xsl:if test="contains(./@n, 'a')">
          <xsl:text>\bigskip{}</xsl:text>
          </xsl:if>-->
        <xsl:text>&#10;&#10;</xsl:text>
        <xsl:text>\par</xsl:text>
        <xsl:text>\hspace*{14pt}\Linum{</xsl:text>
        <xsl:value-of select="@n"/>
        <xsl:text>}</xsl:text>
        <xsl:text>\label{</xsl:text>
        <xsl:value-of select="my:cleanref(@xml:id)"/>
        <!--<xsl:value-of select="@xml:id"/>-->
        <xsl:text>}~</xsl:text>
        <xsl:apply-templates/>
      </xsl:when>
      <!--for all others: -->
      <xsl:otherwise>
        <xsl:if test="(preceding-sibling::lb)">
          <xsl:text></xsl:text>
        </xsl:if>
        <xsl:text>\Linum{</xsl:text>
        <xsl:value-of select="@n"/>
        <xsl:text>}</xsl:text>
        <xsl:text>\label{</xsl:text>
        <xsl:value-of select="my:cleanref(@xml:id)"/>
        <!--<xsl:value-of select="@xml:id"/>-->
        <xsl:text>}~</xsl:text>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  
  
  <!--=============================================-->
  <!--                  <title>                    -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>
      <xd:p>title</xd:p>
      <xd:p>distinguishes between manuscripts,
        printed editions, and normal titles</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="title">
    <xsl:choose>
      <!--manuscripts-->
      <xsl:when test="@type='ms'">
        <xsl:text>\MS</xsl:text>
      </xsl:when>
      <!--editions-->
      <xsl:when test="@type='ed'">
        <xsl:text>\ED</xsl:text>
      </xsl:when>
      <!--normal titles-->  
      <xsl:otherwise>
        <xsl:text>\Title</xsl:text>
        <xsl:if test="@rend='upshape'">
          <xsl:text>*</xsl:text>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    <!-- index: -->
    <xsl:text>{</xsl:text>
    <xsl:choose>
      <xsl:when test="@ana">
        <xsl:sequence select="my:cleantext(@ana)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}</xsl:text>
    <!-- title/ms/ed name --> 
    <xsl:text>{</xsl:text>
    <xsl:choose>
      <xsl:when test="@ana">
        <xsl:sequence select="my:cleantext(@ana)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}</xsl:text>
  </xsl:template>
  
  
  
  <!--=============================================-->
  <!--                     <name>                  -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>
      <xd:p>name</xd:p>
      <xd:p>typesets the name using the \Nombre{} command
        and creates an index entry</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="name">
    <xsl:text>\Nombre{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
    <xsl:text>\index[names]</xsl:text>
    <xsl:text>{</xsl:text> 
    <xsl:choose>
      <xsl:when test="@ana">
        <xsl:sequence select="my:cleantext(@ana)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}</xsl:text>
  </xsl:template>
  
  
  
  <!--=============================================-->
  <!--                     <l>                     -->
  <!--=============================================-->
  
  <xd:doc>
    <xd:desc>
      <xd:p>l[not(parent::lg)]</xd:p>
      <xd:p>standalone line</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="l[not(parent::lg)]">
    <xsl:if test="preceding-sibling::l">
      <xsl:text> /
      </xsl:text>
    </xsl:if>
    <xsl:if test="@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="my:cleanref(@xml:id)"/>
      <!--<xsl:value-of select="@xml:id"/>-->
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>l[parent::lg]</xd:p>
      <xd:p>lines inside a line group</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="l[parent::lg]">
    <xsl:if test="@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="my:cleanref(@xml:id)"/>
      <!--<xsl:value-of select="@xml:id"/>-->
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:text>\\</xsl:text>
  </xsl:template>
  
  
  
  <!--=============================================-->
  <!--                    <lg>                     -->
  <!--=============================================-->
    <xd:doc>
    <xd:desc>
      <xd:p>lg</xd:p>
      <xd:p>line group template uses the myverse environment</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="lg">
    <xsl:text>\begin{myverse}</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>\end{myverse}</xsl:text>
  </xsl:template>
  
  
  
  <!--=============================================-->
  <!--                     <hi>                    -->
  <!--=============================================--> 
  <xd:doc>
    <xd:desc>
      <xd:p>hi</xd:p>
      <xd:p>highlight template,
      takes care of small caps, bold face,
      superscript text, upshape text,
      and defaults to italic text</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="hi">
    <xsl:choose>
      <xsl:when test="@rend='sc'">
        <xsl:text>\textsc{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="@rend='bf'">
        <xsl:text>\textbf{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="@rend='superscript'">
        <xsl:text>\textsuperscript{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="@rend='upshape'">
        <xsl:text>\textup{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>\emph{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <!--=============================================-->
  <!--                     <gap>                   -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>
      <xd:p>gap</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="gap">
    <xsl:text>\elipsis{}</xsl:text>
  </xsl:template>
  
  
  
  <!--=============================================-->
  <!--                  <supplied>                 -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>
      <xd:p>supplied</xd:p>
      <xd:p>@ana='eq' produces: [$=$ ]</xd:p>
      <xd:p>@ana='q' uses parenthesis instead of brackets</xd:p>
      <xd:p>@ana='peq' produces: ($=$ )</xd:p>
    </xd:desc>
  </xd:doc>
  <xd:doc>
    <xd:desc> @ana='peq' produces: ($=$ ) </xd:desc>
  </xd:doc>
  <xsl:template match="supplied">
    <xsl:choose>
      <xsl:when test="@rend='nobrackets'">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="@ana='p' or @ana='peq'">
            <xsl:text>(</xsl:text>
          </xsl:when>  
          <xsl:otherwise>
            <xsl:text>[</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@ana='p' or @ana='peq'">
          <xsl:text>$=$</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:choose>
          <xsl:when test="@ana='p' or @ana='peq'">
            <xsl:text>)</xsl:text>
          </xsl:when>  
          <xsl:otherwise>
            <xsl:text>]</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  
  <!--=============================================-->
  <!--                    <note>                   -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>
      <xd:p>note</xd:p>
      <xd:p>inserts a \notenum command
      and then produced the note content</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="note">
    <!--<!-\-check if two notes go together-\->
      <xsl:if test="preceding-sibling::node()[not(self::text()[normalize-space()=''])][1][self::note]">
      <xsl:text>\notesep</xsl:text>
      </xsl:if>-->
    <xsl:text>&#10;&#10;</xsl:text>
    <xsl:text>\notenum</xsl:text>
    <!--insert label-->
    <xsl:text>{</xsl:text>
    <xsl:value-of select="my:cleanref(@xml:id)"/>
    <!--<xsl:value-of select="@xml:id"/>-->
    <xsl:text>}</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>
  
  
  <!--=============================================-->
  <!--                 <caesura>                   -->
  <!--=============================================-->
  <xd:doc>
    <xd:desc>
      <xd:p>caesura</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="caesura">
    <xsl:text>\caesura{}</xsl:text>
  </xsl:template>
  
  
  
  <!--=============================================-->
  <!--                   <table>                   -->
  <!--=============================================-->
  
  <xd:doc>
    <xd:desc>
      <xd:p>table</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="table">
    <xsl:text>&#10;&#10;\begin{ctabular}{</xsl:text>
    <xsl:value-of select="@rend"/>
    <xsl:text>}</xsl:text>
    <xsl:text>\toprule&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>\bottomrule&#10;</xsl:text>
    <xsl:text>\end{ctabular}&#10;&#10;</xsl:text>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>row</xd:desc>
  </xd:doc>
  <xsl:template match="row">
    <xsl:apply-templates/>
    <xsl:text> \\&#10;</xsl:text>
  </xsl:template>
  
  
  <xd:doc>
    <xd:desc>cell</xd:desc>
  </xd:doc>
  <xsl:template match="cell">
    <xsl:apply-templates/>
    <!--insert &amp; if not last cell in row-->
    <xsl:choose>
      <xsl:when test="following-sibling::cell">
        <xsl:text> &amp; </xsl:text>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>
  
  
  
  <!--=============================================-->
  <!--           miscellaneous elements            -->
  <!--=============================================-->
  
  <xd:doc>
    <xd:desc>
      <xd:p>ab[@ana='leavevmode']</xd:p>
      <xd:p>this is required by LaTeX sometimes</xd:p> 
    </xd:desc>
  </xd:doc>
  <xsl:template match="ab[@ana='leavevmode']">
    <xsl:text>\leavevmode</xsl:text>
  </xsl:template>
  
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>ab[@ana='nl']</xd:p>
      <xd:p>forced new line</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="ab[@ana='nl']">
    <xsl:text>\par</xsl:text>
  </xsl:template>
  
  
  
  
  <xd:doc>
    <xd:desc>
      <xd:p>pc[@ana='notesep']</xd:p>
      <xd:p>separator between consecutive notes</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="pc[@ana='notesep']">
    <xsl:text>\notesep</xsl:text>
  </xsl:template>
  
  
</xsl:stylesheet>