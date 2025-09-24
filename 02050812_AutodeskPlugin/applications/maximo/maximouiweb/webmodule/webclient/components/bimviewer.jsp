<%--
 * IBM Confidential
 *
 * OCO Source Materials
 *
 * 5737-M60, 5737-M66
 *
 * (C) COPYRIGHT IBM CORP. 2009-2025
 *
 * The source code for this program is not published or otherwise
 * divested of its trade secrets, irrespective of what has been
 * deposited with the U.S. Copyright Office.
--%>
<%@page import="psdi.webclient.components.*"%>
<%@page import="psdi.server.MXServer"%>
<%@ include file="../common/componentheader.jsp" %>
<%

// when in design mode return some stub html for App Designer
if(designmode) 
{
	IMAGE_PATH = servletBase + "/"+skin+"images/"+(rtl?"rtl/":"")+wcs.getImagePath();
	%>
    <div>
    <img src="<%=IMAGE_PATH%>bim//ViewerDesignerMode.png" alt="BIM 3D viewer" draggable="false"> 
    </div>
    <%
    return;
}

// Must be bound to an instance of NavisWorks to function
if( !(component instanceof BIMViewer ) )
{
	return;
}
String uiSessionId = wcs.getUISessionID();
BIMViewer bldgMdl = (BIMViewer)component;
IMAGE_PATH = servletBase + "/"+skin+"images/"+(rtl?"rtl/":"")+wcs.getImagePath();

// Designer mode may put "-" into the ID string which make them invalid for JavaScript 
// idenfiers - Get rid of them
id = id.replace( "-", "_" );

String containerTable   = id + "container";

String value   = null;

boolean _needsRendered = bldgMdl.needsRender();


if( _needsRendered )
{%>
	<script type="text/javascript" >
		var jsLibrary = document.createElement('SCRIPT' );
		jsLibrary.type = "text/javascript";
		jsLibrary.src  = "<%=servletBase%>/javascript/bimviewerlib.js";
		if( navigator.appName == "Microsoft Internet Explorer" )
		{
			try
			{
				window.top.document.appendChild( jsLibrary );			// 7.5 wants this
			}
			catch( e ) 
			{
				window.top.document.head.appendChild( jsLibrary );		// 7.6 Want this
			}
		}
		else
		{
			var headers = document.getElementsByTagName('head');
			var head = headers[0];
			head.appendChild( jsLibrary );
		}
		
		<%
		String version = MXServer.getMXServer().getMaxupgValue();
		if( version.startsWith( "V7503" ) )
		{%>
			jsLibrary = document.createElement('SCRIPT' );
			jsLibrary.type = "text/javascript";
			jsLibrary.src  = "<%=servletBase%>/javascript/menus.js";
			if( navigator.appName == "Microsoft Internet Explorer" )
			{
				window.top.document.appendChild( jsLibrary );			// 7.5 wants this
			}
			else
			{
				var headers = document.getElementsByTagName('head');
				var head = headers[0];
				head.appendChild( jsLibrary );
			}
		<%}%>
		
	<%if( bldgMdl.getAppType() ==  BIMViewer.TYPE_LOOKUP )
	{%>
		// Need to allow time for the NavisWorks control to initialize or it fails to bind
		// to its event handlers
		addLoadMethod( 'setTimeout( \'<%=bldgMdl.jspScript( id )%>\', 100 );' );
	<%}
	else
	{%>
		addLoadMethod( 'setTimeout( \'<%=bldgMdl.jspScript( id )%>\', 100 );' );
		//addLoadMethod( '<%=bldgMdl.jspScript( id )%>' );
	<%}%>
	
	</script>
	<%
} 
else
{
	if( bldgMdl.getMxVersion() >= BIMViewer.VERSION_75_OR_GREATER )
	{%>
		<component id="<%=id%>_holder"><%="<![CDATA["%>
			<script>
				setTimeout( '<%=bldgMdl.jspScript( id )%>', 100 );
			</script>
		<%="]]>"%></component>
		<%
	}
	else
	{%>
		<%=bldgMdl.jspScript( id )%>
	<%}
}  
  
if( _needsRendered )
{
	// Force a reload of the model file if the control is being redrawn
	String controlTop = component.getProperty("controltop");
	controlTop = (controlTop == null || controlTop.equalsIgnoreCase("")) ? "250" : controlTop;
	String controlLeft     = component.getProperty("controlleft");
	controlLeft = (controlLeft == null || controlLeft.equalsIgnoreCase("")) ? (rtl?"10":"325") : (rtl?"10":controlLeft);
	String height     = component.getProperty("height");
	height = (height == null) ? "" : height;
	String width     = component.getProperty("width");
	width = (width == null) ? "" : (rtl?"1325":width);
	%>

<div style="position: relative;height: 0;width: 0"> <!-- div so that the frameLoc div doesn't take space even though it's moved relatively -->
	<div id="<%=id%>_frameLoc" style="border: 0px none; position: relative; overflow: hidden; visibility: hidden; display: none; z-index: 10000; height: 1px; width: 1px;">
		<script>
			var jsLibrary = document.createElement('SCRIPT');
			jsLibrary.type = "text/javascript";
			jsLibrary.src  = "<%=servletBase%>/javascript/frameLocLib.js";
			if( navigator.appName == "Microsoft Internet Explorer" )
			{
				window.top.document.head.appendChild( jsLibrary );		// 7.6 Want this
			}
			else
			{
				var headers = document.getElementsByTagName('head');
				var head = headers[0];
				head.appendChild( jsLibrary );
			}	
		</script>
	</div>
</div>

<%
}  // Close else if !bldgMdl.needsRender() )
%>

<%@ include file="../common/componentfooter.jsp" %>
