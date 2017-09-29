<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<!-- 
Implementations Skeletor v3 - 5/10/2014

Contributors: Your Name Here
Last Updated: Enter Date Here
-->
<xsl:stylesheet version="3.0" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xs="http://www.w3.org/2001/XMLSchema"
				xmlns:ou="http://omniupdate.com/XSL/Variables"
				xmlns:fn="http://omniupdate.com/XSL/Functions"
				xmlns:ouc="http://omniupdate.com/XSL/Variables"
				exclude-result-prefixes="ou xsl xs fn ouc">

	<xsl:template match="/document">
		<html>
			<head>
				<meta charset="utf-8" />
				<title><xsl:value-of select="ouc:properties[@label='metadata']" /></title>
				<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />
			</head>

			<body>
				<h1>Accordion Example</h1>

				<!-- Apply Templates to the content region on the page -->
				<xsl:apply-templates select="ouc:div[@label='content-1']" />
				
				<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
			</body>
		</html>

	</xsl:template>



	<!-- template will match any table with the class containing 'ou-accordion' and 
convert it to the accordion code: -->
	<xsl:template match="table[contains(@class, 'ou-accordion')]">
		<xsl:variable name="id" select="generate-id()" />
		<xsl:variable name="heading-level" select="tbody/tr[@class = 'ou-heading-level']/td[@class = 'ou-value']" />
		<xsl:variable name="hlevel">
			<xsl:choose>
				<xsl:when test="$heading-level = '3' or $heading-level = '4' or $heading-level = '5' or $heading-level = '6'"><xsl:value-of select="$heading-level" /></xsl:when>
				<xsl:otherwise>4</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<div class="panel-group" id="accordion{$id}" role="tablist" aria-multiselectable="true">
			<xsl:for-each select="tbody/tr[@class = 'ou-panel']">
				<xsl:variable name="accTitle" select="td[contains(@class, 'ou-title')]/node()" />
				<xsl:variable name="accId">
					<xsl:choose>
						<xsl:when test="td[contains(@class, 'ou-link-id')] != ''">
							<xsl:value-of select="td[contains(@class, 'ou-link-id')]" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat('collapse', $id, '_', position())" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<div class="panel panel-default">
					<div class="panel-heading" role="tab" id="{$accId}-heading">
						<xsl:element name="h{$hlevel}">
							<xsl:attribute name="class">panel-title</xsl:attribute>
							<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion{$id}" href="#{$accId}" aria-expanded="false" aria-controls="{$accId}" aria-label="{$accTitle} Accordion Heading">
								<xsl:if test="td[contains(@class, 'ou-link-title')] != ''">
									<xsl:attribute name="title">
										<xsl:value-of select="td[contains(@class, 'ou-link-title')]" />
									</xsl:attribute>
									<xsl:attribute name="aria-label">
										<xsl:value-of select="td[contains(@class, 'ou-link-title')]" />
									</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="$accTitle" />
							</a>
						</xsl:element>
					</div>
					<div id="{$accId}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="{$accId}-heading">
						<div class="panel-body">
							<xsl:apply-templates select="td[contains(@class, 'ou-content')]/node()" />
						</div>
					</div>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>


</xsl:stylesheet>