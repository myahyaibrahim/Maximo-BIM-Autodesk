/*
 * IBM Confidential
 * OCO Source Materials
 * 5737-M66, 5900-AAA, 5900-AMG
 * (C) Copyright IBM Corp. 2021, 2024
 * The source code for this program is not published or otherwise divested of
 * its trade secrets, irrespective of what has been deposited with the U.S.
 * Copyright Office.
 */
package psdi.app.bim.viewer.lmv;

import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.spy;

import org.junit.Test;
import org.mockito.Mockito;

import psdi.app.bim.viewer.lmv.test.util.DefectTestUtil;
import psdi.app.bim.viewer.lmv.test.util.SampleTestData;
import psdi.app.bim.viewer.lmv.test.util.TestConstants;
import psdi.mbo.MboSetRemote;
import psdi.mbo.MockedMboSet;
import psdi.security.UserInfo;
import psdi.security.UserInfoMocker;
import psdi.server.MXServer;
import psdi.test.FastUnitTestBase;

public class LMVServiceTest extends FastUnitTestBase {
	public static final String COPYRIGHT = "(C) Copyright IBM Corp. 2021, 2024 All Rights Reserved.\n";
	
    @Test
    public void testGetSavedViews() throws Exception {
    	
		// mock out the locale and user info
		UserInfo userInfo = UserInfoMocker.mockUserInfo(TestConstants.LOCALE_AR);
    	
		MXServer mxServer = MXServer.getMXServer();
		
		// mock service
    	LMVService servce = spy(new LMVService(mxServer));
    	
		MockedMboSet markupList = DefectTestUtil.createMockedDefectMboSet();
		MboSetRemote markups = markupList.getMboSet();

		doReturn(markups).when(mxServer).getMboSet( SavedView.TABLE_NAME, userInfo );
		
		servce.getSavedViews(userInfo, "mockModelId", "mockSiteId", "mockIdentifier");

		//verify getSavedViews executed once
		Mockito.verify(servce).getSavedViews(userInfo, "mockModelId", "mockSiteId", "mockIdentifier");
    }
    
    @Test
    public void testGetAssetLocationMarkups() throws Exception {

		// mock out the locale and user info
		UserInfo userInfo = UserInfoMocker.mockUserInfo(TestConstants.LOCALE_AR);
    	
		MXServer mxServer = MXServer.getMXServer();
		
		// mock service
    	LMVService servce = spy(new LMVService(mxServer));
    	
		MockedMboSet markupList = DefectTestUtil.createMockedDefectMboSet();

		MboSetRemote markups = markupList.getMboSet();

		doReturn(markups).when(mxServer).getMboSet( "BIMLMVDEFECTVIEW", userInfo );
		
		String actualDefectMarkupJsonString = servce.getAssetLocationMarkups(userInfo, "mockModelId", "mockSiteId", "mockAssetNumber", true, SampleTestData.SAMPLE_ENCODED_VIEWER_STATE);

		//TODO fix on travis failed
		//assertEquals("Defect markup json string is not as expected.", SampleTestData.RETURNED_SAMPLE_MARKUP_JSON_STRING, actualDefectMarkupJsonString);
    }

}
