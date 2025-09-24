<%--
 * IBM Confidential
 *
 * OCO Source Materials
 *
 * 5737-M60, 5737-M66
 *
 * (C) COPYRIGHT IBM CORP. 2009-2021
 *
 * The source code for this program is not published or otherwise
 * divested of its trade secrets, irrespective of what has been
 * deposited with the U.S. Copyright Office.
--%>
<%
if( _needsRendered )
{%>
	<script>
//alert(">>> bimgetjspscript hit");
	<%if( bldgMdl.getAppType() ==  BIMViewer.TYPE_LOOKUP )
	{%>
		// Need to allow time for the NavisWorks control to initialize or it fails to bind
		// to its event handlers
		addLoadMethod( 'setTimeout( \'<%=bldgMdl.jspScript( id )%>\', 500 );' );
	<%}
	else
	{%>
		// >>> this is the one that i think is erroring
		addLoadMethod( '<%=bldgMdl.jspScript( id )%>' );
	<%}%>
	
	</script>
	<%
		} 
	else
	{
		if( bldgMdl.getMxVersion() >= BIMViewer.VERSION_75_OR_GREATER )
		{
	%>
		<component id="<%=id%>_holder"><%="<![CDATA["%>
			<script>
				setTimeout( '<%=bldgMdl.jspScript( id )%>', 10 );
			</script>
		<%="]]>"%></component>
		<%
	}
	else
	{%>
		<script>
			<%=bldgMdl.jspScript( id )%>
		</script>
	<%}
}  
%>