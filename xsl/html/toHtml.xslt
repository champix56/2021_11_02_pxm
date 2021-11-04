<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY euro "&#x20ac;">
]>
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
				<h1>Sommaire factures</h1>
				<ul>
					<xsl:for-each select="//facture">
						<xsl:sort select="@numfacture"/>
						<li>
							<a href="#facture-{@numfacture}">
								facture N° <xsl:value-of select="@numfacture"/>
							</a>
						</li>
					</xsl:for-each>
				</ul>
				<hr/>
				<xsl:for-each select="//facture">
					<div class="c_facture" id="facture-{@numfacture}">
						<div class="emeteur">emeteur</div>
						<div class="destinataire">destinataire</div>
						<div class="numero">
							Facture N°<xsl:value-of select="@numfacture"/>
							<br/>en date du :<xsl:value-of select="@datefacture"/>
						</div>
						<table>
							<thead>
								<tr>
									<th>ref</th>
									<th>designation</th>
									<th>&euro;/Unit</th>
									<th>Quant</th>
									<th>Sous-total</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td/>
									<td/>
									<td/>
									<td/>
									<td/>
								</tr>
							</tbody>
						</table>
					</div>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
