<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Mes factures</title>
				<!--<link rel="stylesheet" type="text/css" href="html.css"/>-->
				<style type="text/css">
					.c_facture{
						height:27cm;
						page-break-before:always;
						margin-bottom:1cm;
						border:1px solid black;
					}
				</style>
			</head>
			<body>
				<xsl:for-each select="//facture">
					<div class="c_facture" id="facture-{@numfacture}">
					Une facture <xsl:value-of select="@numfacture"/>
				</div>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
