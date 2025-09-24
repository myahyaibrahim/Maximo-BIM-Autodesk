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

      <table id=<%=toolbarId%> style="width:100%"><tr>
		<td align="left" >
		  <table ><tr style="padding:0">
		  	<td>
			  <table style="color:#000000;padding:0"><tr style="height:32">
			    <td>
			    	<img id=<%=id%> src="<%=viewerLogo%>" height="28" style="margin-left:10px; margin-top:4px"/>
		    	</td>
			    <td id=<%=id%>_version  name="<%=id%>_version" align="center" 
			        style="padding:0 5px 0 0;
                           font-size:9; writing-mode: tb-rl; filter: flipv fliph; font-stretch: normal; 
                           -webkit-transform:rotate(90deg); 
                           -moz-transform:rotate(90deg);">
		        </td>
			  </tr></table>
		  	</td>


			<%
				if( appType ==  BIMViewer.TYPE_LOCATION )
				{
			%>
			 <%-- Manage models associated with the location --%>
                <td style="padding:2px">
                        <img src="<%=BIM_IMAGE_PATH%>/tb_iconDivider.png" tabindex="-1" draggable="false">
                </td>
                <td align="left">
                  <img id=<%=id%> name=btnModel title="<%=strings.loadModel%>" 
                       src="<%=BIM_IMAGE_PATH%>/tb_viewModel.png" height="30" width="30" border="0"
                       onClick="window.parent.sendEvent(  'bim_addmod', '<%=bldgMdl.getRenderId()%>' )" >
                </td>
                <td style="padding:2px">
                        <img src="<%=BIM_IMAGE_PATH%>/tb_iconDivider.png" tabindex="-1" draggable="false">
                </td>
     		<%
     			}
     		%>
			<td style="padding:2px; padding-left:4">
				<img id="iconDivider" src="<%=BIM_IMAGE_PATH%>/tb_iconDivider.png"
			    	alt="" tabindex="-1" draggable="false">
			</td> 
            <td><%=strings.lableModel%></td>
			<td style="padding:2px; padding-left:4">
            <td>
              <select id=<%=modelId%> style="width:200" 
                      onChange="modelMgr.selectModel( this, <%=ctrlId%> )">
              </select>
            </td>
            <td style="padding:2px">
            	<img id="iconDivider" src="<%=BIM_IMAGE_PATH%>/tb_iconDivider.png"
			    	alt="" tabindex="-1" draggable="false">
            </td>

            <td style="padding:2px">
			    <a id="<%=autoZoomMode1Id%>" title="<%=strings.autoZoomModeBtn%>" 
			    	href="javascript:toggleAutoZoomMode()" class="on" style="background-image:url('<%=BIM_IMAGE_PATH%>/tb_toggle_bg.png'); display:block;"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="<%=autoZoomMode1Id%>Img" src="<%=BIM_IMAGE_PATH%>/tb_autoZoomToSelected.png" name="autoZoomModei" border="0"
			    	alt="<%=strings.autoZoomModeBtn%>" tabindex="-1" draggable="false">
			    </a>
			</td>
            <%
            	if( bldgMdl.getRecordType() ==  BIMViewer.RECORD_LOCATION )
            		    {
            %>
			 <%-- Clear the current selection and set the current location to the model location --%>
            <td style="padding:2px">
			    <a id="btnGotoLoc" title="<%=strings.gotoLocBtn%>" 
			    	href="javascript:selMgr.clear( <%=ctrlId%> )" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="btnGotoLoci" src="<%=BIM_IMAGE_PATH%>/tb_deselect.png" name="btnGotoLoci" border="0"
			    	alt="<%=strings.gotoLocBtn%>" tabindex="-1" draggable="false">
			    </a>
            <td style="padding:2px">
            <%
            	}
            %>

            <td style="padding:2px">
			    	<img src="<%=BIM_IMAGE_PATH%>/tb_iconDivider.png" tabindex="-1" draggable="false">
			</td>

			<%
				if(    appType ==  BIMViewer.TYPE_ASSET 
				      || appType ==  BIMViewer.TYPE_LOCATION )
				{
			%>

			 <%-- Create a new work order --%>
            <td style="padding:2px">
			    <a id="btnNewWO" title="<%=strings.newWOBtn%>" 
			    	href="javascript:window.parent.sendEvent(  'CREATEWO', '<%=bldgMdl.getRenderId()%>' )" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="btnNewWOi" src="<%=BIM_IMAGE_PATH%>/tb_createWO.png" name="btnNewWOi" border="0"
			    	alt="<%=strings.newWOBtn%>" tabindex="-1" draggable="false">
			    </a>
			</td>
     		<%
     			}
     			if( appType !=  BIMViewer.TYPE_MODEL && appType !=  BIMViewer.TYPE_UNKNOWN )
     			{
     		%>
			

			 <%-- Search for open work orders and service requests --%>
            <td style="padding:2px">
			    <a id="btnSearchWO" title="<%=strings.displayWOBtn%>" href="javascript:maximoIntf.maxSearchWorkOrders()" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="btnSearchWOi" src="<%=BIM_IMAGE_PATH%>/tb_viewWOsandPMs.png" name="btnSearchWOi" border="0"
			    	alt="<%=strings.displayWOBtn%>" tabindex="-1" draggable="false">
			    </a>
			</td>
		     
			<%
		     				}
		     				if(    appType ==  BIMViewer.TYPE_ASSET 
		     				    || appType ==  BIMViewer.TYPE_LOCATION )
		     				{
		     			%>
			
			 <%-- Create a new service request --%>
            <td style="padding:2px">
			    <a id="btnInspectAsset" title="<%=strings.createTicketBtn%>" 
			    	href="javascript:window.parent.sendEvent(  'CREATESR', '<%=bldgMdl.getRenderId()%>' )" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="btnInspectAsseti" src="<%=BIM_IMAGE_PATH%>/tb_newTicket.png" name="btnInspectAsseti" border="0"
			    	alt="<%=strings.createTicketBtn%>" tabindex="-1" draggable="false">
			    </a>
			</td>
			   
     		<%
			        			}
			        			if( bldgMdl.getRecordType() ==  BIMViewer.RECORD_LOCATION )
			        			{
			        		%>
			
			  <%-- Inspect asset details for an opperating location --%>
            <td style="padding:2px">
			    <a id="btnInspectAsseta" title="<%=strings.inspectAssetBtn%>" href="javascript:maxAssetInspect()" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="<%=inspectAssetId%>" src="<%=BIM_IMAGE_PATH%>/tb_findAsset.png" name="btnInspectAsseti" border="0"
			    	alt="<%=strings.inspectAssetBtn%>" tabindex="-1" draggable="false">
			    </a>
			</td>

            <td style="padding:2px">
			    	<img src="<%=BIM_IMAGE_PATH%>/tb_iconDivider.png" tabindex="-1" draggable="false">
			</td>
     		<%
     			}if( appType ==  BIMViewer.TYPE_LOCATION )
     			{
     		%>
			
			  <%-- Create a new system from the current selection --%>
            <td style="padding:2px">
			    <a id="btnNewSystema" title="<%=strings.newSystemBtn%>" href="javascript:maximoIntf.maxSystemsNew()" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="<%=newSystemId%>" src="<%=BIM_IMAGE_PATH%>/tb_newSystem.png" name="btnNewSystemi" border="0"
			    	alt="<%=strings.newSystemBtn%>" tabindex="-1" draggable="false">
			    </a>
			</td>
     		<%
     			}
     			if( appType !=  BIMViewer.TYPE_MODEL && appType !=  BIMViewer.TYPE_UNKNOWN )
     			{
     		%>
		    <%-- Display the compnent of a system as the current selection --%>
            <td style="padding:2px">
			    <a id="btnDisplaySystema" title="<%=strings.displaySystemBtn%>" href="javascript:maximoIntf.maxSystemsDisplay()" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="<%=displaySystemId%>" src="<%=BIM_IMAGE_PATH%>/tb_openSystem.png" name="btnDisplaySystemi" border="0"
			    	alt="<%=strings.displaySystemBtn%>" tabindex="-1" draggable="false">
			    </a>
			</td>

     		<%
     			}
     			if( appType ==  BIMViewer.TYPE_LOCATION )
     			{
     		%>
			  <%-- Update an existing system from the current selection --%>
            <td style="padding:2px">
			    <a id="btnUpdateSystema" title="<%=strings.updateSystemBtn%>" href="javascript:maximoIntf.maxSystemsUpdate()" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="<%=updateSystemId%>" src="<%=BIM_IMAGE_PATH%>/tb_editSystem.png" name="btnUpdateSystemi" border="0"
			    	alt="<%=strings.updateSystemBtn%>" tabindex="-1" draggable="false" class="toolbar">
			    </a>
			</td>
     		<%
     			}
     		%>

     		<%
     			if( appType ==  BIMViewer.TYPE_WORKORDER )
     			{
     		%> 
            <td style="padding:2px">
			    	<img src="<%=BIM_IMAGE_PATH%>/tb_iconDivider.png" tabindex="-1" draggable="false">
			</td>

			  <%-- Add or remove the current selection from a workorder or a ticket --%>
            <td style="padding:2px">
			    <a id="addSelectionBtna" title="<%=strings.addSelectionBtn%>" href="javascript:maximoIntf.maxSelectionAdd()" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="<%=addSelectionId%>" src="<%=BIM_IMAGE_PATH%>/tb_add.png" name="addSelectionBtni" border="0"
			    	alt="<%=strings.addSelectionBtn%>" tabindex="-1" draggable="false">
			    </a>
			</td>

            <td style="padding:2px">
			    <a  id="removeSelectionBtna" title="<%=strings.removeSelectionBtn%>" href="javascript:maximoIntf.maxSelectionRemove()" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="<%=removeSelectionId%>" src="<%=BIM_IMAGE_PATH%>/tb_remove.png" name="removeSelectionBtni" border="0"
			    	alt="<%=strings.removeSelectionBtn%>" tabindex="-1" draggable="false">
			    </a>
			</td>
     		<%
     			}
     		%>


		  </tr></table>
		</td> 
		
		<%-- Resize button --%>
		<td align="right">
		  <table><tr>
		    <td style="padding:2px"></td> 
            <%
             	if( viewerVendor == VENDOR_NAVISWORKS )
             	{
             %>
			<td> 
			    <ul class="toolbar">
			    <li>
			    <a id="btnRefresh" title="<%=strings.refreshBtn%>" href="javascript:refreshBtn()" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="btnRefreshi" src="<%=BIM_IMAGE_PATH%>/tb_refresh.png" name="btnRefreshi" 
			    	alt="<%=strings.refreshBtn%>" tabindex="-1" draggable="false">
			    </a>
			    </li>
			    </ul>
			</td>
            <%
            	}
            %>
		    <td style="padding:2px"></td> 
			  <td> 
				<%
 					if( appType !=  BIMViewer.TYPE_LOOKUP ) 
 						{
 				%>
			    <ul class="toolbar">
			    <li>
			    <a id="btnRestore" title="<%=strings.resizeBtn%>" 
                	onClick="resizeBtn( event )" 
                    href="javascript:void(null);" class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="btnRestorei" src="<%=BIM_IMAGE_PATH%>/tb_resize.png" name="btnRestorei" 
			    	alt="<%=strings.resizeBtn%>" tabindex="-1" draggable="false">
			    </a>
			    </li>
			    </ul>
			    
			    <%} else {%>  
			    <ul class="toolbar">
			    <li>
			    <a id="btnDlgResize" title="<%=strings.resizeBtn%>" 
                	onClick="resizeDlgBtn( event )" 
                    href="javascript:void(null);"  class="on"
			    	onfocus="setCurrentfocusId(event, this);appendClass(this,'onhover')" onBlur="removeClass(this,'onhover')">
			    	<img id="btnDlgResizei" src="<%=BIM_IMAGE_PATH%>/tb_resize.png" name="btnDlgResizei" 
			    	alt="<%=strings.resizeBtn%>" tabindex="-1" draggable="false">
			    </a>
			    </li>
			    </ul>
			    <%}%>
			  </td>
			<td style="padding:2px"></td> 
		  </tr></table>
	    </td> 
	  </tr>
    </table>
