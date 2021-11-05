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
						width:20cm;
						page-break-before:always;
						margin-bottom:1cm;
						border:1px solid black;
					}
					.emeteur{
						width:5cm;
						height:3cm;
						margin-bottom:2cm;
					}
					.destinataire{
						width:5cm;
						height:3cm;
						margin-left:13cm;
						margin-bottom:1cm;
					}
					.numero{
						width:60%;
						margin-left:20%;
						text-align:center;
						border:1mm solid black;
						padding:0.5cm 0;
						margin-bottom:1cm;
					}
					table{
						width:80%;
						margin-left:10%;
					}
					table thead th{background-color:lightgrey;}
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
				<xsl:apply-templates select="//facture">
					<xsl:sort select="@type"/>
				</xsl:apply-templates>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="facture[contains(@type,'evis')]">
		<div class="c_devis" id="facture-{@numfacture}" style="background-color:skyblue;">
			C'est un devis
		</div>
	</xsl:template>
	<xsl:template match="facture">
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
					<xsl:apply-templates select=".//ligne"/>
				</tbody>
			</table>
		</div>
	</xsl:template>
	<xsl:template match="ligne">
		<tr>
			<td>
				<xsl:value-of select="ref"/>
			</td>
			<td>
				<xsl:value-of select="designation"/>
			</td>
			<td>
				<xsl:value-of select="phtByUnit"/>
			</td>
			<td>
				<xsl:value-of select="nbUnit"/>
			</td>
			<td>
				<xsl:value-of select="stotligne"/>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
