<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

	<!-- TODO add comments! -->

	<xsl:param name="file" required="true"/>

	<xsl:template name="xsl:initial-template">
		<revhistory
			xmlns="http://docbook.org/ns/docbook"
			xmlns:xl="http://www.w3.org/1999/xlink"
			version="5.0"
			xml:lang="en">
			<xsl:analyze-string regex="([^\n]*)\n([^\n]*)\n([^\n]*)\n([^\n]*)\n" select="unparsed-text($file)">
				<xsl:matching-substring>
					<revision>
						<revnumber>
							<link xl:href="https://github.com/Youth-Tech-Net/anu-hub-constitution/commit/{regex-group(1)}">
								<xsl:value-of select="regex-group(2)"/>
							</link>
						</revnumber>
						<date><xsl:value-of select="regex-group(3)"/></date>
						<revremark><xsl:value-of select="regex-group(4)"/></revremark>
					</revision>
				</xsl:matching-substring>
			</xsl:analyze-string>
		</revhistory>
	</xsl:template>

</xsl:stylesheet>
