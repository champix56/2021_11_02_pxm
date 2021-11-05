<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4Portrait" page-height="297mm" page-width="210mm">
					<fo:region-body margin-bottom="10mm" margin-top="20mm"/>
					<fo:region-before extent="2cm"/>
					<fo:region-after extent="1cm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<xsl:apply-templates select="//page"/>
		</fo:root>
	</xsl:template>
	<xsl:template match="page">
		<fo:page-sequence master-reference="A4Portrait">
			<fo:static-content flow-name="xsl-region-before">
				<fo:block font-size="7mm" color="skyblue" text-align="center">
					<xsl:value-of select="/photos/titre"/>
				</fo:block>
			</fo:static-content>
			<fo:flow flow-name="xsl-region-body">
				<fo:block>
					<fo:table>
						<fo:table-body>
							<fo:table-row>
								<xsl:apply-templates select="image[position() &lt;= 2]"/>
							</fo:table-row>
							<xsl:if test="count(image) &gt; 2">
								<fo:table-row>
									<xsl:apply-templates select="image[position() &gt; 2]"/>
								</fo:table-row>
							</xsl:if>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	<xsl:template match="page/image">
		<fo:table-cell text-align="center">
			<fo:block>
				<fo:external-graphic src="{@path}{@href}" scaling="uniform" content-height="98mm" content-width="98mm"/>
				<xsl:if test="/photos/@OnlyComment='false'">
					<fo:block>
						<xsl:value-of select="@href"/>
					</fo:block>
				</xsl:if>
				<fo:block>
					<xsl:value-of select="."/>
				</fo:block>
			</fo:block>
		</fo:table-cell>
	</xsl:template>
</xsl:stylesheet>
