<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<xsl:processing-instruction name="mso-application">progid="Excel.Sheet"</xsl:processing-instruction>
		<!--<?mso-application progid="Excel.Sheet"?>-->
		<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
			<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
				<Author>bastien laurent</Author>
				<LastAuthor>bastien laurent</LastAuthor>
				<Created>2021-10-20T12:42:53Z</Created>
				<Version>16.00</Version>
			</DocumentProperties>
			<OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
				<AllowPNG/>
			</OfficeDocumentSettings>
			<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
				<WindowHeight>11760</WindowHeight>
				<WindowWidth>14010</WindowWidth>
				<WindowTopX>32767</WindowTopX>
				<WindowTopY>32767</WindowTopY>
				<ProtectStructure>False</ProtectStructure>
				<ProtectWindows>False</ProtectWindows>
			</ExcelWorkbook>
			<Styles>
				<Style ss:ID="Default" ss:Name="Normal">
					<Alignment ss:Vertical="Bottom"/>
					<Borders/>
					<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>
					<Interior/>
					<NumberFormat/>
					<Protection/>
				</Style>
				<Style ss:ID="s63">
					<Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
				</Style>
				<Style ss:ID="s67">
					<Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
					<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FF0000"/>
				</Style>
				<Style ss:ID="s70">
					<Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
					<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FF0000"/>
					<NumberFormat ss:Format="#,##0.00\ &quot;€&quot;"/>
				</Style>
				<Style ss:ID="s71">
					<NumberFormat ss:Format="#,##0.00\ &quot;€&quot;"/>
				</Style>
				<Style ss:ID="s72">
					<NumberFormat ss:Format="Short Date"/>
				</Style>
			</Styles>
			<Worksheet ss:Name="Contenu de factures">
				<Table ss:ExpandedColumnCount="7" ss:ExpandedRowCount="{2+count(//facture)}" x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="60" ss:DefaultRowHeight="15">
					<Column ss:Index="5" ss:AutoFitWidth="0" ss:Width="93"/>
					<Column ss:AutoFitWidth="0" ss:Width="92.25"/>
					<Column ss:Width="76.5"/>
					<Row ss:Height="18.75">
						<Cell ss:MergeAcross="1" ss:StyleID="s63">
							<Data ss:Type="String">Nb de factures</Data>
						</Cell>
						<Cell ss:StyleID="s67">
							<Data ss:Type="Number">
								<xsl:value-of select="count(//facture)"/>
							</Data>
						</Cell>
						<Cell ss:MergeAcross="1" ss:StyleID="s63">
							<Data ss:Type="String">montant total des factures</Data>
						</Cell>
						<Cell ss:StyleID="s70">
							<Data ss:Type="Number">
								<xsl:value-of select="sum(//stotligne)"/>
							</Data>
						</Cell>
					</Row>
					<Row>
						<Cell>
							<Data ss:Type="String">Numero</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">date facture</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">Idclient</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">nbLignes</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">nombre d'articles</Data>
						</Cell>
						<Cell>
							<Data ss:Type="String">montant total</Data>
						</Cell>
					</Row>
					<!--application du template pour chaque facture-->
					<xsl:apply-templates select="//facture"/>
				</Table>
				<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
					<PageSetup>
						<Header x:Margin="0.3"/>
						<Footer x:Margin="0.3"/>
						<PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
					</PageSetup>
					<Print>
						<ValidPrinterInfo/>
						<PaperSizeIndex>9</PaperSizeIndex>
						<HorizontalResolution>600</HorizontalResolution>
						<VerticalResolution>600</VerticalResolution>
					</Print>
					<Selected/>
					<Panes>
						<Pane>
							<Number>3</Number>
							<ActiveRow>6</ActiveRow>
							<ActiveCol>6</ActiveCol>
						</Pane>
					</Panes>
					<ProtectObjects>False</ProtectObjects>
					<ProtectScenarios>False</ProtectScenarios>
				</WorksheetOptions>
			</Worksheet>
		</Workbook>
	</xsl:template>
	<xsl:template match="facture">
		<Row>
			<Cell><Data ss:Type="Number">
					<xsl:value-of select="@numfacture"/>
			</Data></Cell>
			<Cell ss:StyleID="s72"><Data ss:Type="String">
					<xsl:value-of select="@datefacture"/>
			</Data></Cell>
			<Cell><Data ss:Type="Number">
					<xsl:value-of select="@idclient"/>
			</Data></Cell>
			<Cell><Data ss:Type="Number">
					<xsl:value-of select="count(.//ligne)"/>
			</Data></Cell>
			<Cell><Data ss:Type="Number">
					<xsl:value-of select="sum(.//nbUnit)"/>
			</Data></Cell>
			<Cell ss:StyleID="s71"><Data ss:Type="Number">
					<xsl:value-of select="sum(.//stotligne)"/>
			</Data></Cell>
		</Row>
	</xsl:template>
</xsl:stylesheet>
