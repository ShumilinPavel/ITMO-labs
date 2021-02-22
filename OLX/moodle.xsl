<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <quiz>
            <question type="category">
                <category>
                    <text>$course$/top/Default for m1-2021</text>
                </category>
                <info format="moodle_auto_format">
                    <text>The default category for questions shared in context 'm1-2021'.</text>
                </info>
                <idnumber />
            </question>
            <xsl:apply-templates select="problem/ol/li/*" />
        </quiz>
    </xsl:template>

    <xsl:template match="multiplechoiceresponse">
        <question type="multichoice">
            <name>
                <text>
                    <xsl:value-of select="concat(substring(normalize-space(label/string()), 1, 30), '...')" />
                </text>
            </name>
            <questiontext format="html">
                <xsl:variable name="nodestring">
                    <xsl:apply-templates select="label/node()" mode="serialize" />
                </xsl:variable>
                <text>
                    <xsl:value-of disable-output-escaping="yes"
                    select="concat('&lt;![CDATA[ ', normalize-space($nodestring), ' ]]>')" />
                </text>
            </questiontext>
            <generalfeedback format="html">
                <text />
            </generalfeedback>
            <defaultgrade>1.0000000</defaultgrade>
            <penalty>0.3333333</penalty>
            <hidden>0</hidden>
            <idnumber />
            <single>true</single>
            <shuffleanswers>true</shuffleanswers>
            <answernumbering>abc</answernumbering>
            <correctfeedback format="html">
                <text>Your answer is correct.</text>
            </correctfeedback>
            <partiallycorrectfeedback format="html">
                <text>Your answer is partially correct.</text>
            </partiallycorrectfeedback>
            <incorrectfeedback format="html">
                <text>Your answer is incorrect.</text>
            </incorrectfeedback>
            <shownumcorrect />
            <xsl:apply-templates select="choicegroup" />
        </question>
    </xsl:template>

    <xsl:template match="choicegroup">
        <xsl:for-each select="choice">
            <xsl:variable name="fraction">
                <xsl:choose>
                    <xsl:when test="@correct = 'true'">
                        <xsl:value-of select="100" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="0" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <answer fraction="{$fraction}" format="html">
                <xsl:variable name="nodestring">
                    <xsl:apply-templates select="node()" mode="serialize" />
                </xsl:variable>
                <text>
                    <xsl:value-of disable-output-escaping="yes"
                    select="concat('&lt;![CDATA[ ', normalize-space($nodestring), ' ]]>')" />
                </text>
                <feedback format="html">
                    <text />
                </feedback>
            </answer>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="stringresponse">
        <question type="shortanswer">
            <name>
                <text>
                    <xsl:value-of select="concat(substring(normalize-space(label/string()), 1, 30), '...')" />
                </text>
            </name>
            <questiontext format="html">
                <xsl:variable name="nodestring">
                    <xsl:apply-templates select="label/node()" mode="serialize" />
                </xsl:variable>
                <text>
                    <xsl:value-of disable-output-escaping="yes"
                    select="concat('&lt;![CDATA[ ', normalize-space($nodestring), ' ]]>')" />
                </text>
            </questiontext>
            <generalfeedback format="html">
                <text />
            </generalfeedback>
            <defaultgrade>1.0000000</defaultgrade>
            <penalty>0.3333333</penalty>
            <hidden>0</hidden>
            <idnumber />
            <usecase>0</usecase>
            <answer fraction="100" format="moodle_auto_format">
                <text>
                    <xsl:value-of select="@answer" />
                </text>
                <feedback format="html">
                    <text />
                </feedback>
            </answer>
            <xsl:apply-templates select="additional_answer" />
        </question>
    </xsl:template>

    <xsl:template match="additional_answer">
        <answer fraction="100" format="moodle_auto_format">
            <text>
                <xsl:value-of select="@answer" />
            </text>
            <feedback format="html">
                <text />
            </feedback>
        </answer>
    </xsl:template>

    <xsl:template match="*" mode="serialize">
        <xsl:choose>
            <xsl:when test="name() = 'br'">
                <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
                <xsl:value-of select="name()" />
                <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
                <xsl:apply-templates mode="serialize" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
                <xsl:value-of select="name()" />
                <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
                <xsl:apply-templates mode="serialize" />
                <xsl:text disable-output-escaping="yes">&lt;/</xsl:text>
                <xsl:value-of select="name()" />
                <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="text()" mode="serialize">
        <xsl:value-of select="." />
    </xsl:template>

</xsl:stylesheet>