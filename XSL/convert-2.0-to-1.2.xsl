<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:epcis="urn:epcglobal:epcis:xsd:1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no" />

	<!-- configure inclusion of elements that have been introduced with EPCIS 2.0 -->
	<xsl:variable name="includeAssociationEvent" select ="'yes'" />
	<xsl:variable name="includePersistentDisposition" select ="'yes'" />
	<xsl:variable name="includeSensorElementList" select ="'yes'" />

	<!-- entry-point for root element(s) -->
	<xsl:template match="/*">
		<xsl:choose>
			<!-- match EPCISDocument version 2.0 -->
			<xsl:when test="name() = 'epcis:EPCISDocument' and @schemaVersion = '2.0'">
				<xsl:call-template name="convert-to-1.2" />
			</xsl:when>
			<!-- simply copy otherwise -->
			<xsl:otherwise>
				<xsl:copy-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- convert EPCISDocument version 2.0 to 1.2 -->
	<xsl:template name="convert-to-1.2">
		<epcis:EPCISDocument xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xmlns:epcis="urn:epcglobal:epcis:xsd:1" schemaVersion="1.2">
			<xsl:attribute name="creationDate">
				<xsl:value-of select="@creationDate" />
			</xsl:attribute>
			<EPCISBody>
				<!-- copy attributes to keep user user defined extension -->
				<xsl:apply-templates mode="copy-nodes" select="EPCISBody/@*"/>
				<xsl:for-each select="EPCISBody/*">
					<xsl:choose>
						<!-- match EventList -->
						<xsl:when test="name() = 'EventList'">
							<EventList>
								<!-- copy attributes to keep user user defined extension -->
								<xsl:apply-templates mode="copy-nodes" select="@*"/>
								<!-- loop through EventList child nodes-->
								<xsl:for-each select="*">
									<xsl:if test="name() = 'ObjectEvent'">
										<ObjectEvent>
											<xsl:apply-templates mode="copy-nodes" select="@*"/>
											<xsl:call-template name="convert-ObjectEvent" />
										</ObjectEvent>
									</xsl:if>
									<xsl:if test="name() = 'AggregationEvent'">
										<AggregationEvent>
											<xsl:apply-templates mode="copy-nodes" select="@*"/>
											<xsl:call-template name="convert-AggregationEvent" />
										</AggregationEvent>
									</xsl:if>
									<xsl:if test="name() = 'TransformationEvent'">
										<extension>
											<TransformationEvent>
												<xsl:apply-templates mode="copy-nodes" select="@*"/>
												<xsl:call-template name="convert-TransformationEvent" />
											</TransformationEvent>
										</extension>
									</xsl:if>
									<xsl:if test="name() = 'TransactionEvent'">
										<TransactionEvent>
											<xsl:apply-templates mode="copy-nodes" select="@*"/>
											<xsl:call-template name="convert-TransactionEvent" />
										</TransactionEvent>
									</xsl:if>
									<xsl:if test="name() = 'AssociationEvent' and $includeAssociationEvent = 'yes'">
										<extension>
											<AssociationEvent>
												<xsl:apply-templates mode="copy-nodes" select="@*"/>
												<xsl:call-template name="convert-AssociationEvent" />
											</AssociationEvent>
										</extension>
									</xsl:if>
								</xsl:for-each>
							</EventList>
						</xsl:when>
						<!-- simply copy otherwise -->
						<xsl:otherwise>
							<xsl:apply-templates mode="copy-nodes" select="." />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</EPCISBody>
		</epcis:EPCISDocument>
	</xsl:template>

	<!-- no-op for any well-known EPCIS elements in copy-nodes mode -->
	<xsl:template mode="copy-nodes" match="EPCISBody|EventList|ObjectEvent|AggregationEvent|TransformationEvent|TransactionEvent|AssociationEvent|extension">
	</xsl:template>

	<!-- convert EPCISEvent base type elements -->
	<xsl:template name="convert-EPCISEvent">
		<xsl:apply-templates mode="copy-nodes" select="eventTime"/>
		<xsl:if test="recordTime">
			<xsl:apply-templates mode="copy-nodes" select="recordTime"/>
		</xsl:if>
		<xsl:apply-templates mode="copy-nodes" select="eventTimeZoneOffset"/>
		<xsl:if test="eventID or errorDeclaration or extension">
			<baseExtension>
				<xsl:apply-templates mode="copy-nodes" select="eventID"/>
				<!-- adding errorDeclaration explicitly because it must respect sequence of elements in EPCIS 1.2 -->
				<xsl:if test="errorDeclaration">
					<errorDeclaration>
						<xsl:apply-templates mode="copy-nodes" select="errorDeclaration/@*"/>
						<xsl:apply-templates mode="copy-nodes" select="errorDeclaration/declarationTime"/>
						<xsl:apply-templates mode="copy-nodes" select="errorDeclaration/reason"/>
						<xsl:apply-templates mode="copy-nodes" select="errorDeclaration/correctiveEventIDs"/>
						<xsl:apply-templates mode="copy-nodes" select="errorDeclaration/extension"/>
						<!-- copy user-defined extension -->
						<xsl:if test="errorDeclaration/*[not(name()='declarationTime' or name()='reason' or name()='correctiveEventIDs' or name()='extension')]">
							<xsl:apply-templates mode="copy-nodes" select="errorDeclaration/*[not(name()='declarationTime' or name()='reason' or name()='correctiveEventIDs' or name()='extension')]"/>
						</xsl:if>
					</errorDeclaration>
				</xsl:if>
				<!-- adding extension explicitly because it's excluded from copy-nodes mode -->
				<xsl:if test="extension">
					<xsl:apply-templates mode="copy-nodes" select="extension"/>
				</xsl:if>
			</baseExtension>
		</xsl:if>
	</xsl:template>

	<!-- convert EPCIS 2.0 ObjectEvent to 1.2 -->
	<xsl:template name="convert-ObjectEvent">
		<xsl:call-template name="convert-EPCISEvent" />
		<!-- variable user-defined extensions -->
		<xsl:variable name="userExtensionAtRoot" select="*[not(name()='eventTime' or name()='recordTime' or name()='eventTimeZoneOffset' or name()='eventID' or name()='errorDeclaration'
			or name()='epcList' or name()='bizStep' or name()='action' or name()='disposition' or name()='readPoint' or name()='bizLocation' or name()='bizTransactionList'
			or name()='quantityList' or name()='sourceList' or name()='destinationList' or name()='persistentDisposition' or name()='sensorElementList' or name()='ilmd' or name()='extension')]"/>

		<xsl:choose>
			<xsl:when test="epcList">
				<xsl:apply-templates mode="copy-nodes" select="epcList"/>
			</xsl:when>
			<xsl:otherwise>
				<epcList/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates mode="copy-nodes" select="action|bizStep|disposition|readPoint|bizLocation|bizTransactionList"/>
		<xsl:if test="quantityList or sourceList or destinationList or persistentDisposition or sensorElementList or ilmd or $userExtensionAtRoot">
			<extension>
				<xsl:apply-templates mode="copy-nodes" select="quantityList|sourceList|destinationList"/>
				<!-- adding ilmd explicitly because it's excluded from copy-nodes mode -->
				<xsl:if test="ilmd">
					<xsl:apply-templates mode="copy-nodes" select="ilmd"/>
				</xsl:if>
				<xsl:if test="persistentDisposition or sensorElementList or $userExtensionAtRoot">
					<extension>
						<!-- only include sensorElementList if configured -->
						<xsl:if test="sensorElementList and $includeSensorElementList = 'yes'">
							<xsl:apply-templates mode="copy-nodes" select="sensorElementList"/>
						</xsl:if>
						<!-- only include persistentDisposition if configured -->
						<xsl:if test="persistentDisposition and $includePersistentDisposition = 'yes'">
							<xsl:apply-templates mode="copy-nodes" select="persistentDisposition"/>
						</xsl:if>
						<!-- adding extension explicitly because it's excluded from copy-nodes mode -->
						<xsl:if test="$userExtensionAtRoot">
							<extension>
								<xsl:apply-templates mode="copy-nodes" select="$userExtensionAtRoot"/>
							</extension>
						</xsl:if>
					</extension>
				</xsl:if>
			</extension>
		</xsl:if>
	</xsl:template>

	<!-- convert EPCIS 2.0 AggregationEvent to 1.2 -->
	<xsl:template name="convert-AggregationEvent">
		<xsl:call-template name="convert-EPCISEvent" />
		<!-- TODO: add specific elements -->
		<!-- variable user-defined extensions -->
		<xsl:variable name="userExtensionAtRoot" select="*[not(name()='eventTime' or name()='recordTime' or name()='eventTimeZoneOffset' or name()='eventID' or name()='errorDeclaration'
		or name()='parentID' or name()='childEPCs' or name()='bizStep' or name()='action' or name()='disposition' or name()='readPoint' or name()='bizLocation' or name()='bizTransactionList'
		or name()='childQuantityList' or name()='sourceList' or name()='destinationList' or name()='persistentDisposition' or name()='sensorElementList' or name()='extension')]"/>

		<xsl:apply-templates mode="copy-nodes" select="parentID"/>
		<xsl:choose>
			<xsl:when test="childEPCs">
				<xsl:apply-templates mode="copy-nodes" select="childEPCs"/>
			</xsl:when>
			<xsl:otherwise>
				<childEPCs/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates mode="copy-nodes" select="action|bizStep|disposition|readPoint|bizLocation|bizTransactionList"/>
		<xsl:if test="childQuantityList or sourceList or destinationList or persistentDisposition or sensorElementList or $userExtensionAtRoot">
			<extension>
				<xsl:apply-templates mode="copy-nodes" select="childQuantityList|sourceList|destinationList"/>
				<xsl:if test="persistentDisposition or sensorElementList or $userExtensionAtRoot">
					<extension>
						<!-- only include sensorElementList if configured -->
						<xsl:if test="sensorElementList and $includeSensorElementList = 'yes'">
							<xsl:apply-templates mode="copy-nodes" select="sensorElementList"/>
						</xsl:if>
						<!-- only include persistentDisposition if configured -->
						<xsl:if test="persistentDisposition and $includePersistentDisposition = 'yes'">
							<xsl:apply-templates mode="copy-nodes" select="persistentDisposition"/>
						</xsl:if>
						<!-- adding extension explicitly because it's excluded from copy-nodes mode -->
						<xsl:if test="$userExtensionAtRoot">
							<extension>
								<xsl:apply-templates mode="copy-nodes" select="$userExtensionAtRoot"/>
							</extension>
						</xsl:if>
					</extension>
				</xsl:if>
			</extension>
		</xsl:if>
	</xsl:template>

	<!-- convert EPCIS 2.0 TransformationEvent to 1.2 -->
	<xsl:template name="convert-TransformationEvent">
		<xsl:call-template name="convert-EPCISEvent" />
		<!-- TODO: add specific elements -->
		<xsl:variable name="userExtensionAtRoot" select="*[not(name()='eventTime' or name()='recordTime' or name()='eventTimeZoneOffset' or name()='eventID' or name()='errorDeclaration'
		    or name()='bizStep' or name()='action' or name()='disposition' or name()='readPoint' or name()='bizLocation' or name()='bizTransactionList'
		    or name()='sourceList' or name()='destinationList' or name()='persistentDisposition' or name()='sensorElementList' or name()='extension'
			or name()='inputEPCList' or name()='inputQuantityList' or name()='outputEPCList' or name()='outputQuantityList' or name()='transformationID' or name()='ilmd')]"/>

		<xsl:apply-templates mode="copy-nodes" select="inputEPCList|inputQuantityList|outputEPCList|outputQuantityList|transformationID|
        bizStep|disposition|readPoint|bizLocation|bizTransactionList|sourceList|destinationList"/>
		<!-- adding ilmd explicitly because it's excluded from copy-nodes mode -->
		<xsl:if test="ilmd">
			<xsl:apply-templates mode="copy-nodes" select="ilmd"/>
		</xsl:if>
		<xsl:if test="persistentDisposition or sensorElementList or $userExtensionAtRoot">
			<extension>
				<!-- only include sensorElementList if configured -->
				<xsl:if test="sensorElementList and $includeSensorElementList = 'yes'">
					<xsl:apply-templates mode="copy-nodes" select="sensorElementList"/>
				</xsl:if>
				<!-- only include persistentDisposition if configured -->
				<xsl:if test="persistentDisposition and $includePersistentDisposition = 'yes'">
					<xsl:apply-templates mode="copy-nodes" select="persistentDisposition"/>
				</xsl:if>
				<!-- adding extension explicitly because it's excluded from copy-nodes mode -->
				<xsl:if test="$userExtensionAtRoot">
					<extension>
						<xsl:apply-templates mode="copy-nodes" select="$userExtensionAtRoot"/>
					</extension>
				</xsl:if>
			</extension>
		</xsl:if>
	</xsl:template>

	<!-- convert EPCIS 2.0 TransactionEvent to 1.2 -->
	<xsl:template name="convert-TransactionEvent">
		<xsl:call-template name="convert-EPCISEvent" />
		<!-- TODO: add specific elements -->

		<!-- variable user-defined extensions -->
		<xsl:variable name="userExtensionAtRoot" select="*[not(name()='eventTime' or name()='recordTime' or name()='eventTimeZoneOffset' or name()='eventID' or name()='errorDeclaration'
			or name()='parentID' or name()='epcList' or name()='action' or name()='bizStep' or name()='disposition' or name()='readPoint' or name()='bizTransactionList'
			or name()='bizLocation' or name()='quantityList' or name()='sourceList' or name()='destinationList' or name()='sensorElementList' or name()='persistentDisposition'
			or name()='extension')]"/>

		<xsl:choose>
			<xsl:when test="bizTransactionList">
				<xsl:apply-templates mode="copy-nodes" select="bizTransactionList"/>
			</xsl:when>
			<xsl:otherwise>
				<epcList/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates mode="copy-nodes" select="parentID"/>
		<xsl:choose>
			<xsl:when test="epcList">
				<xsl:apply-templates mode="copy-nodes" select="epcList"/>
			</xsl:when>
			<xsl:otherwise>
				<epcList/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates mode="copy-nodes" select="action|bizStep|disposition|readPoint|bizLocation"/>
		<xsl:if test="quantityList or sourceList or destinationList or persistentDisposition or sensorElementList or $userExtensionAtRoot">
			<extension>
				<xsl:apply-templates mode="copy-nodes" select="quantityList|sourceList|destinationList"/>
				<xsl:if test="persistentDisposition or sensorElementList or $userExtensionAtRoot">
					<extension>
						<!-- only include sensorElementList if configured -->
						<xsl:if test="sensorElementList and $includeSensorElementList = 'yes'">
							<xsl:apply-templates mode="copy-nodes" select="sensorElementList"/>
						</xsl:if>
						<!-- only include persistentDisposition if configured -->
						<xsl:if test="persistentDisposition and $includePersistentDisposition = 'yes'">
							<xsl:apply-templates mode="copy-nodes" select="persistentDisposition"/>
						</xsl:if>
						<!-- adding extension explicitly because it's excluded from copy-nodes mode -->
						<xsl:if test="$userExtensionAtRoot">
							<extension>
								<xsl:apply-templates mode="copy-nodes" select="$userExtensionAtRoot"/>
							</extension>
						</xsl:if>
					</extension>
				</xsl:if>
			</extension>
		</xsl:if>
	</xsl:template>

	<!-- convert EPCIS 2.0 AssociationEvent to 1.2 -->
	<xsl:template name="convert-AssociationEvent">
		<xsl:call-template name="convert-EPCISEvent" />
		<!-- TODO: add specific elements -->
		<!-- variable user-defined extensions -->
		<xsl:variable name="userExtensionAtRoot" select="*[not(name()='eventTime' or name()='recordTime' or name()='eventTimeZoneOffset' or name()='eventID' or name()='errorDeclaration'
			or name()='parentID' or name()='childEPCs' or name()='childQuantityList' or name()='action' or name()='bizStep' or name()='disposition' or name()='readPoint'
			or name()='bizLocation' or name()='bizTransactionList' or name()='sourceList' or name()='destinationList' or name()='sensorElementList' or name()='persistentDisposition'
			or name()='extension')]"/>

		<xsl:apply-templates mode="copy-nodes" select="parentID|childEPCs|childQuantityList|action|bizStep|disposition|readPoint|bizLocation|bizTransactionList"/>
		<!-- only include sensorElementList if configured -->
		<xsl:if test="sensorElementList and $includeSensorElementList = 'yes'">
			<xsl:apply-templates mode="copy-nodes" select="sensorElementList"/>
		</xsl:if>
		<!-- only include persistentDisposition if configured -->
		<xsl:if test="persistentDisposition and $includePersistentDisposition = 'yes'">
			<xsl:apply-templates mode="copy-nodes" select="persistentDisposition"/>
		</xsl:if>
		<xsl:if test="$userExtensionAtRoot">
			<extension>
				<xsl:apply-templates mode="copy-nodes" select="$userExtensionAtRoot"/>
			</extension>
		</xsl:if>
	</xsl:template>

	<!-- node copy template to prevent unwanted attributes -->
	<xsl:template match="*" mode="copy-nodes">
		<xsl:element name="{name()}" namespace="{namespace-uri()}">
			<xsl:apply-templates select="@*|node()" mode="copy-nodes" />
		</xsl:element>
	</xsl:template>

	<!--
		 prevent xmlns:epcis to be added to attribues
		required for enforcing urn:epcglobal:epcis:xsd:1
	 -->
	<xsl:template match="@*" mode="copy-nodes">
		<xsl:if test="name() != 'xmlns:epcis'">
			<xsl:copy />
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>