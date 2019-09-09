<?xml version="1.0"?>

<!-- Identify as a stylesheet -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- Import the usual html conversion templates            -->
  <xsl:import href="/home/jirka/mathbook/xsl/mathbook-html.xsl"/>

  <!-- Intend output for rendering by html -->
  <!--<xsl:output method="html" />-->

  <!-- apply-imports applies also the original, apply-templates ignores the original-->
  <!-- need hardcoded numbers on everything, so nonstandard mathbookxml -->
  <xsl:template match="men|mrow|exercise|example|remark|theorem|chapter|appendix|section|subsection|subsubsection" mode="number">
    <xsl:choose>
      <xsl:when test="@number">
        <xsl:value-of select="@number"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Want hardcoded reference labels so nonstandard mathbookxml -->
  <xsl:template match="biblio" mode="serial-number">
    <xsl:choose>
      <xsl:when test="@tag">
        <xsl:value-of select="@tag"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- need multline so allow custom environments -->
  <xsl:template match="me|men" mode="displaymath-alignment">
    <xsl:choose>
      <xsl:when test="@latexenv">
        <xsl:value-of select="@latexenv"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- EEEK, this seems a hack, this will add a start attribute if given -->
  <xsl:template match="ol" mode="insert-paragraph-id">
    <xsl:apply-imports/>
    <xsl:if test="@start">
      <xsl:attribute name="start">
        <xsl:value-of select="@start"/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!-- need break, so nonstandard mathbookxml -->
  <xsl:template match="diffyqsbr">
    <br/>
  </xsl:template>

  <!-- need inline image, custom width, maxwidth, etc.., so nonstandard -->
  <!-- the image should be without extension .svg is appended -->
  <xsl:template match="diffyqsimage">
    <xsl:element name="img">
      <xsl:attribute name="class">
        <xsl:text>diffyimg</xsl:text>
        <xsl:if test="@float">
          <xsl:choose>
            <xsl:when test="@float = 'left'">
              <xsl:text> diffyfloatleft</xsl:text>
            </xsl:when>
            <xsl:when test="@float = 'right'">
              <xsl:text> diffyfloatright</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:if>
      </xsl:attribute>
      <xsl:attribute name="style">
        <xsl:if test="@width">
          <xsl:text>width:</xsl:text>
          <xsl:value-of select="@width"/>
          <xsl:text>; </xsl:text>
        </xsl:if>
        <xsl:if test="@maxwidth">
          <xsl:text>max-width:</xsl:text>
          <xsl:value-of select="@maxwidth"/>
          <xsl:text>; </xsl:text>
        </xsl:if>
        <xsl:if test="@height">
          <xsl:text>height:</xsl:text>
          <xsl:value-of select="@height"/>
          <xsl:text>; </xsl:text>
        </xsl:if>
        <xsl:if test="@background-color">
          <xsl:text>background-color:</xsl:text>
          <xsl:value-of select="@background-color"/>
          <xsl:text>; </xsl:text>
        </xsl:if>
		<!--<xsl:text>margin:auto; vertical-align:middle;</xsl:text>-->
        <xsl:choose>
          <xsl:when test="@inline = 'yes'">
				</xsl:when>
          <xsl:otherwise>
            <xsl:text>display:block;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="src">
        <xsl:value-of select="@source"/>
        <xsl:text>.svg</xsl:text>
      </xsl:attribute>
      <!-- alt attribute for accessibility -->
      <xsl:attribute name="alt">
        <xsl:apply-templates select="description"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>

  <!-- we almost never reference figures/tables from afar, so knowlizing the 
       xref seems unnecessary and it just makes things a bit confusing -->
  <xsl:template match="figure|table" mode="xref-as-knowl">
    <xsl:value-of select="false()" />
  </xsl:template>

  <xsl:param name="html.knowl.theorem" select="'no'"/>
  <xsl:param name="html.knowl.proof" select="'yes'"/>
  <xsl:param name="html.knowl.definition" select="'no'"/>
  <xsl:param name="html.knowl.example" select="'no'"/>
  <xsl:param name="html.knowl.list" select="'no'"/>
  <xsl:param name="html.knowl.remark" select="'no'"/>
  <xsl:param name="html.knowl.figure" select="'no'"/>
  <xsl:param name="html.knowl.table" select="'no'"/>
  <xsl:param name="html.knowl.listing" select="'no'"/>
  <xsl:param name="html.knowl.exercise.inline" select="'no'"/>
  <xsl:param name="html.knowl.exercise.sectional" select="'no'"/>

  <xsl:param name="debug.datedfiles" select="'no'"/>

  <xsl:param name="html.css.extra" select="'extra.css'"/>

  <xsl:param name="html.google-search" select="'006490116505509195242:1mxn4dbgh8e'"/>

</xsl:stylesheet>
