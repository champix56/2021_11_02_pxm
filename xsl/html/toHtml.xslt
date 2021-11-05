<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY euro "&#x20ac;">
	<!ENTITY nbsp "&#160;">
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
					.totalTitre{
						text-align:right;
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
	<xsl:template match="@rsets">
		<div class="emeteur">
			<xsl:value-of select="."/>
			<br/>
			<xsl:value-of select="/factures/@adr1ets"/>
			<br/>
			<xsl:value-of select="/factures/@cpets"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="/factures/@villeets"/>
		</div>
	</xsl:template>
	<xsl:template match="clients/client">
			<xsl:value-of select="destinataire"/>
			<br/>
			<xsl:value-of select="adr1"/>
			<br/>
			<xsl:value-of select="cp"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="ville"/>
	</xsl:template>
	<xsl:template match="facture">
		<div class="c_facture" id="facture-{@numfacture}">
			<xsl:apply-templates select="/factures/@rsets"/>
			<div class="destinataire">
			<xsl:variable name="idc" select="@idclient"/>
				<xsl:variable name="client" select="document('../clients.xml')/clients/client[@id=$idc]"/>
				<xsl:apply-templates select="$client"/>
			</div>
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
				<tfoot>
					<xsl:call-template name="totaux"/>
				</tfoot>
			</table>
		</div>
	</xsl:template>
	<xsl:decimal-format name="euro" decimal-separator="," grouping-separator=" "/>
	<xsl:template name="totaux">
		<!--arrondi au centimes pour calculs-->
		<xsl:variable name="totalht" select="format-number(sum(.//stotligne),'0.00')"/>
		<xsl:variable name="totaltva" select="format-number($totalht * 0.2,'0.00')"/>
		<tr>
			<th colspan="4" class="totalTitre">Total HT</th>
			<!--arrondi au centime pour affichage-->
			<th>
				<xsl:value-of select="format-number($totalht,'# ##0,00&euro;','euro')"/>
			</th>
		</tr>
		<tr>
			<th colspan="4" class="totalTitre">Total TVA</th>
			<!--arrondi au centime pour affichage-->
			<th>
				<xsl:value-of select="format-number($totaltva,'# ##0,00&euro;','euro')"/>
			</th>
		</tr>
		<tr>
			<th colspan="4" class="totalTitre">Total TTC</th>
			<!--arrondi au centime pour affichage-->
			<th>
				<xsl:value-of select="format-number($totaltva + $totalht,'# ##0,00&euro;','euro')"/>
			</th>
		</tr>
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
