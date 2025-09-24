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
<%@page import="psdi.server.MXServer"%>
<%
	MXServer server    = MXServer.getMXServer();
	String adHost      = server.getProperty( "bim.viewer.LMV.host" );
	String lmvversion  = server.getProperty( "bim.viewer.LMV.viewer.version" );
	if( lmvversion == null ) lmvversion = "";
	// ?v=v1.2.15
	String lmvtheme    = server.getProperty( "bim.viewer.LMV.theme" );
	if( lmvtheme == null ) lmvtheme = "8"; 
	
	//String three     = "https://" + adHost + "/viewingservice/v1/viewers/three.min.js" + lmvversion;
	//String style     = "https://" + adHost + "/viewingservice/v1/viewers/style.css" + lmvversion;
	//String viewer3D  = "https://" + adHost + "/viewingservice/v1/viewers/viewer3D.js" + lmvversion;
	String style     = server.getProperty( "bim.viewer.LMV.viewer.style" );
	String three     = server.getProperty( "bim.viewer.LMV.viewer.three" );
	String viewer3D  = server.getProperty( "bim.viewer.LMV.viewer.viewer3D" );
	String lmvworker = "https://" + adHost + "/viewingservice/v1/viewers/lmvworker.js" + lmvversion;
%>
<% if(style != null && !style.equals(""))	{ %>
<link rel="stylesheet" type="text/css" href="<%=style%>" integrity="sha384-jSW4/POeVm2YrbTHLd+bBCpeN1ECL1NHAg8PSHx4wD6wkkla0nQ9TZjOH4w8iyDD" crossorigin="anonymous"/>
<% } %>
<link rel="stylesheet" type="text/css" href="<%=CSS_PATH_MAS8%>LMV.css" />
<% if(three != null && !three.equals(""))	{ %>
<script type = "text/javascript" 
	src="<%=three%>">
</script>
<% } %>
<% if(viewer3D != null && !viewer3D.equals(""))	{ %>
<script type = "text/javascript" 
	src="<%=viewer3D%>" integrity="sha384-TPNFxHp1yjCYgSBcmKymTpQfeeW7Tn/atoyCFSk66rhWx//1vRkgGF5AR48Cny/f" crossorigin="anonymous">
</script>
<% } %>
<%--
<script  type = "text/javascript" 
	src="<%=lmvworker%>">
</script>
--%>
<script type = "text/javascript" 
	src  = "<%=servletBase%>/javascript/gunzip.min.js" >
</script>
<script type = "text/javascript" 
    src  = "<%=servletBase%>/javascript/Forge.js">
</script>
<script type = "text/javascript" 
    src  = "<%=servletBase%>/javascript/LMV.js">
</script>
<script type = "text/javascript" 
    src  = "<%=servletBase%>/javascript/LMV_Markup.js">
</script>
<script type = "text/javascript" 
    src  = "<%=servletBase%>/javascript/MaimoForgeMarkup.js">
</script>
