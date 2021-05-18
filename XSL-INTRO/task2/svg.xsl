<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
    <html>
        <body>
            <h4 id="author" title="GossJS">Павел Шумилин</h4>
            <div style="text-align:center; margin: 20px">
                <xsl:apply-templates />
            </div>
        </body>
    </html>
    </xsl:template>

    <xsl:template match="графика">
        <svg height="{@высота}" width="{@ширина}">
            <xsl:for-each select="эллипс">
                <ellipse id="{@id}" fill="{@заливка}" stroke="{@ободок}" stroke-width="{@ширина-ободка}"
                    cx="{@cx}" cy="{@cy}" rx="{@rx}" ry="{@ry}" />
            </xsl:for-each>
        </svg>
    </xsl:template>

</xsl:stylesheet>