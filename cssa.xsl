<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:db="http://docbook.org/ns/docbook"
                xmlns:f="http://docbook.org/ns/docbook/functions"
                xmlns:m="http://docbook.org/ns/docbook/modes"
		xmlns:tmp="http://docbook.org/ns/docbook/templates"
		xmlns:v="http://docbook.org/ns/docbook/variables"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="db xs"
		version="3.0">

	<!-- print.xsl generates output for screen and print use -->
	<xsl:import href="xsltng/xslt/print.xsl"/>

	<xsl:param name="user-css-links" select="'css/cssa.css'"/>

	<!-- Include revision history on the title page -->
	<xsl:variable name="v:templates" as="document-node()">
		<xsl:document>
			<db:article>
				<header>
					<tmp:apply-templates select="db:title">
						<h1><tmp:content/></h1>
					</tmp:apply-templates>
					<tmp:apply-templates select="db:subtitle">
						<h2><tmp:content/></h2>
					</tmp:apply-templates>
					<tmp:apply-templates select="db:author">
						<div class="author">
							<h3><tmp:content/></h3>
						</div>
					</tmp:apply-templates>
					<tmp:apply-templates select="db:editor">
						<div class="editor">
							<h3><tmp:content/></h3>
						</div>
					</tmp:apply-templates>
					<tmp:apply-templates select="db:pubdate">
						<p class="pubdate"><tmp:content/></p>
					</tmp:apply-templates>
					<tmp:apply-templates select="db:revhistory"/>
				</header>
			</db:article>
		</xsl:document>
	</xsl:variable>

	<xsl:variable name="v:custom-localizations">
		<locale xmlns="http://docbook.org/ns/docbook/l10n/source"
			language="en"
			english-language-name="English">

			<!-- Sections appear as 1 Name instead of 1. Name (no period) -->
			<group name="label-separator">
				<template match="self::db:section" xml:space="preserve"> </template>
				<template match="self::db:sect1" xml:space="preserve"> </template>
				<template match="self::db:sect2" xml:space="preserve"> </template>
				<template match="self::db:sect3" xml:space="preserve"> </template>
				<template match="self::db:sect4" xml:space="preserve"> </template>
				<template match="self::db:sect5" xml:space="preserve"> </template>
			</group>

			<!-- List items are called "subsection" when cross-referenced -->
			<group name="xref">
				<template match="self::db:listitem">subsection %l</template>
			</group>

		</locale>
	</xsl:variable>

	<xsl:param name="unwrap-paragraphs" select="'true'"/>

	<!-- Cross-references to subsections include the section number and all enclosing subsection (list) numbers -->
	<xsl:template match="db:orderedlist/db:listitem" as="item()*" mode="m:headline-number">
		<xsl:param name="purpose" as="xs:string" required="yes"/>

		<xsl:variable name="number" as="xs:integer" select="f:orderedlist-item-number(.)[last()]"/>

		<xsl:variable name="format" select="f:orderedlist-item-numeration(.)"/>

		<xsl:apply-templates select="parent::*/(ancestor::db:listitem[parent::db:orderedlist]|ancestor::db:section)[last()]" mode="m:headline-number">
			<xsl:with-param name="purpose" select="$purpose"/>
		</xsl:apply-templates>
		<xsl:if test="exists($format)">
			<xsl:number value="$number" format="({$format})"/>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
