<%--
* IBM Confidential
*
* OCO Source Materials
*
* 5737-M60, 5737-M66
*
* (C) COPYRIGHT IBM CORP. 2009-2018,2023
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
    <!-- img src="<%=IMAGE_PATH%>bim//ViewerDesignerMode.png" alt="BIM 3D viewer" draggable="false" --> 
	BIMTarget
    </div>
    <%
    return;
}

// Must be bound to an instance of BIMTarget to function
if( !(component instanceof BIMTarget ) )
{
	return;
}
String uiSessionId = wcs.getUISessionID();
BIMTarget bimTarget = (BIMTarget)component;
IMAGE_PATH = servletBase + "/"+skin+"images/"+(rtl?"rtl/":"")+wcs.getImagePath();

// Designer mode may put "-" into the ID string which make them invalid for JavaScript 
// idenfiers - Get rid of them
id = id.replace( "-", "_" );

boolean _needsRendered = bimTarget.needsRender();


if( _needsRendered )
{%>
<%
} 
else
{
%>
<%
}  
  
if( _needsRendered )
{
	String controlTop = component.getProperty("controltop");
	controlTop = (controlTop == null || controlTop.equalsIgnoreCase("")) ? "0" : controlTop;
	String controlLeft     = component.getProperty("controlleft");
	controlLeft = (controlLeft == null || controlLeft.equalsIgnoreCase("")) ? "0" : controlLeft;
	String height     = component.getProperty("height");
	height = (height == null || height.equalsIgnoreCase("")) ? "100%" : height + "px";
	String width     = component.getProperty("width");
	width = (width == null || width.equalsIgnoreCase("")) ? "100%" : width + "px";
	%>

<div id="<%=id%>" style="left: <%=controlLeft%>px; top: <%=controlTop%>px; height: <%=height%>; width: <%=width%>; border-style: none; position: relative; overflow: hidden; visibility: visible; ">
</div>
<script>
    function locRectToWindRect( elem ) {
		var target = elem;
		var target_width = target.offsetWidth;
		var target_height = target.offsetHeight;
		var target_left = target.offsetLeft;
		var target_top = target.offsetTop;
		var gleft = 0;
		var gtop = 0;
		var rect = {};

		var getHigher = function( parentElem ) {
			if (!!parentElem) {
				gleft += parentElem.offsetLeft;
				gtop += parentElem.offsetTop;
				getHigher( parentElem.offsetParent );
			} else {
				return rect = {
					top: target.offsetTop + gtop,
					left: target.offsetLeft + gleft,
					bottom: (target.offsetTop + gtop) + target_height,
					right: (target.offsetLeft + gleft) + target_width
				};
			}
		};
		getHigher( target.offsetParent );
		return rect;
	}

	//debugger;
	var targ = document.getElementById("<%=id%>");
	if(targ != null) {
		var targRect = locRectToWindRect( targ );
<%
	if(width == null || width.equalsIgnoreCase("100%")) {
		%>
		targ.style.width = (document.documentElement.clientWidth - targRect.left - 25) + "px";
		<%
	}
	if(height == null || height.equalsIgnoreCase("100%")) {
		%>
		targ.style.height = (document.documentElement.clientHeight - targRect.top - 25) + "px";
		<%
	}
%>
	}
</script>
<%
}  // Close else if !bimTarget.needsRender() )
%>

<%@ include file="../common/componentfooter.jsp" %>
